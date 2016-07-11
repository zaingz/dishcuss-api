class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :location , :opening ,:closing , :owner ,:followers_count , :likers_count
  has_one :menu

  def opening
  	object.opening_time.strftime("%I:%M %P")
  end

  def closing
  	object.closing_time.strftime("%I:%M %P")
  end

  def owner
  	object.owner.as_json(except: [:created_at, :updated_at , :password])
  end
end
