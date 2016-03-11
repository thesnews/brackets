class User < ActiveRecord::Base
  Roles = %[user admin]

  has_many :brackets

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  def admin?
    role.to_s == 'admin'
  end

  class << self
    def from_omniauth(provider, auth)
      t = self.arel_table
      query = t["#{provider}_uid"].eq(auth.uid)
        .or(t[:email].eq(auth.info.email))
      user = self.where(query).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
      end
      if user["#{provider}_uid"].nil?
        user["#{provider}_uid"] = auth.uid
        user.save
      end
      user
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.oauth_data"] and session["devise.oauth_data"]["extra"]["raw_info"]
          user.email = data['email'] if user.email.blank?
          user.name = data['info']['name'] if user.name.blank?
          user["#{data['provider']}_uid"] = data['uid']
        end
      end
    end
  end
end
