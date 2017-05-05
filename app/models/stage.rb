class Stage < ApplicationRecord
  extend FriendlyId
  acts_as_paranoid

  belongs_to :owner, :class_name => 'User'

  has_many :avatar_stages, :dependent => :destroy
  has_many :avatars, :through => :avatar_stages

  has_many :stage_tags, :dependent => :destroy
  has_many :tags, :through => :stage_tags

  has_many :messages, dependent: :destroy


  friendly_id :name, :use => [ :slugged, :finders ]

  validates :name, :presence => true
  validates :owner, :presence => true
end
