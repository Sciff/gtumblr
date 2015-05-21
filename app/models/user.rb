class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations

  attr_accessor :current_password

  validates :first_name, :last_name, presence: true

  mount_uploader :avatar, AvatarUploader

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      params.permit(:current_password)
      update_attributes(params, *options)
    else
      super
    end
  end

  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
      end
    end

    def new_with_session(params, session)
      if session['devise.user_attributes']
        new(session['devise.user_attributes'], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end
  end

end
