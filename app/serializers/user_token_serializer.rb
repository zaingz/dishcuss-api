class UserTokenSerializer < ActiveModel::Serializer
  root :user
  attributes :id , :name, :username, :email, :gender ,:provider , :token 

  def id
  	object.user.id
  end
  def name
  	object.user.name
  end
  def username
  	object.user.username
  end
  def email
  	object.user.email
  end
  def gender
  	object.user.gender
  end
end
