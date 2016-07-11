class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :summary, :rating , :reviewable_id , :reviewable_type , :reviewer ,:likes
  has_many :comments
  has_many :reports

  def reviewer
  	User.find(object.reviewer_id).as_json(except: [:created_at, :updated_at , :password])
  end

  def likes
  	object.likers(User).as_json(except: [:created_at, :updated_at , :password])
  end
end
