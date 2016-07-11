class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :status , :writer
  has_one :checkin
  has_many :comments
  has_many :photos

  def writer
  	object.user.as_json(except: [:created_at, :updated_at , :password])
  end
end
