class Sound < ApplicationRecord
  extend FriendlyId

  acts_as_paranoid

  has_many :sound_tags, :dependent => :destroy
  has_many :tags, :through => :sound_tags

  has_attached_file :source

  friendly_id :name, :use => [ :slugged, :finders ]

  validates :name, :presence => true
  validates_attachment_content_type :source, content_type: /\Aaudio\/.*\z/
end
