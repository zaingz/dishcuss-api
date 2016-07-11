class Menu < ActiveRecord::Base
	belongs_to :restaurant
	has_many :food_items, dependent: :destroy

	accepts_nested_attributes_for :food_items
end
