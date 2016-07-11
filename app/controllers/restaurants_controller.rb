class RestaurantsController < ApplicationController
	before_filter :restrict_access
	before_filter :is_restaurant_owner , only:[:create , :destroy , :update]

	def create
		restaurant = Restaurant.new restaurant_params
		restaurant.owner_id = @owner.id
		if restaurant.save
			if params[:restaurant][:image].present?
				params[:restaurant][:image].each do |a|
	            	@photo = Photo.create(:image => a, :imageable_id => restaurant.id , :imageable_type => 'Restaurant')
	          	end
	        end
			render json: restaurant, status: :created
		else
			render json: {'message' => 'Unprocessable Entity'} , status: :unprocessable_entity
		end
	end

	def index
		res = Restaurant.approved
		render json: res, status: :ok
	end

	def destroy
		restaurant = Restaurant.approved.where(owner_id: @owner.id)
		if restaurant = restaurant.where(id: params[:id])
			res = Restaurant.approved.find(params[:id])
			res.destroy
			head :no_content
		end
	end

	def update
		restaurant = Restaurant.approved.where(owner_id: @owner.id)
		if restaurant = restaurant.find(params[:id])
			restaurant.update_attributes(restaurant_params)
			if params[:restaurant][:image].present?
				if params[:restaurant][:photo_id].present? && params[:restaurant][:image].count==1
					p = restaurant.photos.find(params[:restaurant][:photo_id])
					
					p.update image: params[:restaurant][:image].first
				else
					params[:restaurant][:image].each do |a|
	            		@photo = Photo.create(:image => a, :imageable_id => restaurant.id , :imageable_type => 'Restaurant')
	          		end
	          	end
			end
			render json: {'message' => 'Restaurant successfully updated!'} , status: :ok
		end
	end

	def social
		restaurant = Restaurant.approved.find(params[:id])
		render json: restaurant , serializer: RestaurantSocialSerializer, status: :ok
	end

	#def likeable
	#	restaurant = Restaurant.approved.find(params[:id])
	#	user = restaurant.likers(User)
	#	render json: user , serializer: Serializer, status: :ok
	#end

	def follow
		if follows = Restaurant.approved.find(params[:id])
			if @current_user.follows?(follows)
				render json: {'message' => 'Already followed!'} , status: :unprocessable_entity
			else
				@current_user.follow!(follows)
				type = 'Restaurant'
				n = NotificationHelper.followed_notification(@current_user.id , follows.id , type)
				render json: {'message' => 'Successfully followed!'} , status: :ok
			end
		end
	end

	def unfollow
		follows = Restaurant.approved.find(params[:id])
		if @current_user.follows?(follows)
			@current_user.unfollow!(follows)
			type = 'Restaurant'
			n = NotificationHelper.unfollowed_notification(@current_user.id , follows.id , type)
			render json: {'message' => 'Successfully unfollowed!'} , status: :ok
		else
			render json: {'message' => 'Follow restaurant first!'} , status: :bad_request
		end
	end

	private
	def restaurant_params
		params.require(:restaurant).permit(:name , :opening_time , :closing_time , :location , :image ,:photo_id)
	end
end
