class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook]

  def self.find_by_provider_and_uid(auth, uid)
    user = User.where(:provider => auth, :uid => uid).first
    return user
  end  

  def self.create_with_omniauth(auth)
    create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.email    = auth.info.email 
      user.password = auth.uid 
      user.save
    end
  end
end