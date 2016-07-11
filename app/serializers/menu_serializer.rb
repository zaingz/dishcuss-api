class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :summary
  has_many :food_items
end
