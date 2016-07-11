class FoodItemSerializer < ActiveModel::Serializer
  attributes :id , :name, :price , :likes , :category
  has_many :photos

  def likes
  	object.likers(User).as_json(except: [:created_at, :updated_at , :password])
  end

  def category
  	object.categories
  end
end
