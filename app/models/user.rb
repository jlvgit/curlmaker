class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:microsoft_office365]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      #puts data (this shows the info in the response from the oauth like name and email)
        user = User.create(name: data["first_name"],
           email: data["email"],
           password: Devise.friendly_token[0,20]
        )
    end
    user
  end
end
