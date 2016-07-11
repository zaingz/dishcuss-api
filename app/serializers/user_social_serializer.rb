class UserSocialSerializer < ActiveModel::Serializer
  root :user
  attributes :id , :name, :username, :email, :avatar , :location , :gender , :role , :following ,:followers , :likes
  has_many :posts
  has_many :reviews
  has_many :messages , serializer: MessageWithRestaurantSerializer

  def following
  	object.followees(User).as_json(except: [:created_at, :updated_at , :password])
  end

  def followers
  	object.followers(User).as_json(except: [:created_at, :updated_at , :password])
  end

  def likes
  	object.likees_count
  end
end
