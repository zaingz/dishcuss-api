class RestaurantSocialSerializer < ActiveModel::Serializer
  root :restaurant
  attributes :id , :name, :location ,  :opening ,:closing , :like , :follow
  has_one :menu
  has_many :reviews
  has_many :photos
  has_many :messages , serializer: MessageWithUserSerializer


  def opening
    object.opening_time.strftime("%I:%M %P")
  end

  def closing
    object.closing_time.strftime("%I:%M %P")
  end
  
  def like
  	object.likers(User).as_json(except: [:created_at, :updated_at , :password])

  end

  def follow
  	object.followers(User).as_json(except: [:created_at, :updated_at , :password])
  end

end
