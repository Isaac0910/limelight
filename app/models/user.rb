class User < ApplicationRecord
  extend FriendlyId

  before_create { generate_token(:auth_token) }
  before_create { generate_token(:confirmation_token) }

  after_create :send_email_confirmation
  after_update :send_activation_email

  scope :active, -> { where(:is_active => true) }
  scope :inactive, -> { where(:is_active => false) }

  has_secure_password
  acts_as_paranoid

  has_many :user_roles
  has_many :roles, :through => :user_roles

  validates :email, :email => true, :presence => true, :uniqueness => true
  validates :nickname, :presence => true, :length => { minimum: 3 }, :uniqueness => true


  friendly_id :nickname, use: [ :slugged, :finders ]

  private
    def generate_token(column)
      self[column] = SecureRandom.urlsafe_base64
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end

    def send_email_confirmation
      UserMailer.confirm_email(self).deliver_now
    end

    def send_activation_email
      debugger
      if self.is_active_was == false && self.is_active
        UserMailer.account_activated(self).deliver_now
      end
    end
end
