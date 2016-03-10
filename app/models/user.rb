class User < ActiveRecord::Base
  Roles = %[user admin]

  has_many :brackets

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  def admin?
    role.to_s == 'admin'
  end

  class << self
    def from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
      end
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] and session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
          user.name = data["info"]["name"] if user.name.blank?
        end
      end
    end
  end
end
