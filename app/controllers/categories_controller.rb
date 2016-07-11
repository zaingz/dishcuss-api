class CategoriesController < ApplicationController
	before_filter :restrict_access
	before_filter :is_restaurant_owner
	def create
		category = Category.new category_params
		if category.save
			render json: category , status: :created
		else
			render json: {'message' => 'Unprocessable entity'}, status: :unprocessable_entity
		end
	end

	private
	def category_params
		params.require(:category).permit(:name)
	end
end
