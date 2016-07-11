class AdminController < ApplicationController
	before_filter :restrict_access
	before_filter :is_admin

	def feature_restaurant
		restaurant = Restaurant.approved.find(params[:id])
		restaurant.featured = true
		if restaurant.save
			render json: {'message' => 'Restaurant successfully featured!'} , status: :ok
		else
			render json: {'message' => 'Unprocessable Entity'} , status: :unprocessable_entity
		end
	end
	
	def approve_restaurant
		restaurant = Restaurant.find(params[:id])
		restaurant.approved = true
		if restaurant.save
			render json: {'message' => 'Restaurant successfully approved!'} , status: :ok
		else
			render json: {'message' => 'Unprocessable Entity'} , status: :unprocessable_entity
		end
	end

	def create_pundit
		if user = User.find_by_email(params[:user][:email])
			render json: {'message' => 'Already signedup!'} , status: :ok
		else
			if params[:user][:password].present?
				user = User.create pundit_params
				render json: {'message' => 'Successfully created!'} , status: :created
			else
				render json: {'message' => 'Missing params!'} , status: :unprocessable_entity
			end
		end
	end

	private
	def pundit_params
		params.require(:user).permit(:email, :password)
	end
end
