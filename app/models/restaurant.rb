class Restaurant < ActiveRecord::Base
	has_one :menu , dependent: :destroy
	belongs_to :owner , :class_name => 'User'
	has_many :reviews , :as => 'reviewable'

	acts_as_followable
	acts_as_likeable

	has_many :photos , :as => 'imageable'
	accepts_nested_attributes_for :photos

	has_many :messages

	has_many :notifications , :as => 'target'

	has_many :dislikes, :as => 'dislikable'

	attr_accessor :image
	attr_accessor :photo_id

	scope :approved, lambda {where(:approved => true)}
	scope :featured, lambda {where(:featured => true)}
end
