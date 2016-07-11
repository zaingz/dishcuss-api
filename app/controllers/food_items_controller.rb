class FoodItemsController < ApplicationController
	before_filter :restrict_access
	before_filter :is_restaurant_owner

	def create
		if menu = Restaurant.find(params[:food_item][:restaurant_id]).menu

			@food_item = FoodItem.new food_item_params
			@food_item.menu_id = menu.id
			if @food_item.save
				if params[:food_item][:category_id].present?
					if params[:food_item][:category_id].count > 1
						params[:food_item][:category_id].each do |a|
							@food_item.categories << Category.find(a)
						end
					else
						@food_item.categories << Category.find(params[:food_item][:category_id].first)
					end		
				end
				if params[:food_item][:category].present?
					params[:food_item][:category].each do |a|
						category = Category.create(:name => a[:name])
						@food_item.categories << category
					end
				else
					@food_item.categories << Category.find_by_name('Uncategorized')
				end
				if params[:food_item][:image].present?
					params[:food_item][:image].each do |a|
		            	@photo = Photo.create(:image => a, :imageable_id => @food_item.id , :imageable_type => 'FoodItem')
		          	end
		        end
				render json: @food_item, status: :created
			else
				render json: {'message' => 'Unprocessable entity'}, status: :unprocessable_entity
			end
		end
	end

	def update
		if food = FoodItem.find(params[:id])
			food.update(food_item_update_params)
			if params[:food_item][:category].present?
				params[:food_item][:category].each do |a|
					category = Category.create(:name => a[:name])
					food.categories << category
				end
			end
			if params[:food_item][:category_id].present?
				params[:food_item][:category_id].each do |a|
					food.categories.delete(a[:id])
					newCat = Category.create(:name => a[:name])
					food.categories << newCat
				end	
			end
			if params[:food_item][:image].present?
				if params[:food_item][:photo_id].present? && params[:food_item][:image].count==1
					p = food.photos.find(params[:food_item][:photo_id])
					
					p.update image: params[:food_item][:image].first
				else
					params[:food_item][:image].each do |a|
	            		@photo = Photo.create(:image => a, :imageable_id => food.id , :imageable_type => 'FoodItem')
	          		end
	          	end
			end
			render json: {'message' => 'Successfully Updated!'}, status: :ok
		end
	end

	#def show
	#	if food = FoodItem.find(params[:id])
	#		render json: food, status: :ok
	#	end
	#end

	def destroy
		if food = FoodItem.find(params[:id])
			food.destroy
			head :no_content
		end
	end

	#def likeable
	#	@food_item = FoodItem.find(params[:id])
	#	@food_item.likers(User).each do |user|
	#		render json: ("first_name: " + user.first_name + ", last_name: " + user.last_name) , status: :ok
	#	end
	#end



	private
	def food_item_params
		params.require(:food_item).permit(:restaurant_id , :name , :price , :image , category: [:name] )
	end

	def food_item_update_params
		params.require(:food_item).permit(:name , :price ,:photo_id , :image , category: [:name] , category_id: [:id , :name] )
	end

	def join_params
		params.require(:food_category).permit(:category_id,:food_item_id)
	end
end
