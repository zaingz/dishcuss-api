class User < ActiveRecord::Base
	validates_uniqueness_of :username
	enum gender: [:male , :female]
	enum role: [:end_user , :restaurant_owner , :admin , :food_pundit]
	has_many :identities ,dependent: :destroy
	has_one :restaurant
	has_many :reviews, :as => 'reviewable'
	has_many :posts
	has_many :reports
	has_many :messages
	has_one :review ,:as => 'reviewer'
	has_one :notification , :as => 'notifier'
	accepts_nested_attributes_for :identities
	#has_secure_password

	acts_as_follower
  	acts_as_followable
  	acts_as_liker

  	has_many :notifications , :as => 'target'
  	has_many :dislikes , :as => 'disliker'
end
