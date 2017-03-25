require 'koala'
class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes
  has_many :notifications, foreign_key: 'recipient_id'
  acts_as_followable
  acts_as_follower
  has_secure_password validations: false

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      access_token = auth['credentials']['token']
      user.provider = auth.provider 
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token 
      user.oauth_token_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end 

  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def get_image_url
    "http://graph.facebook.com/#{self.uid}/picture"
  end
end
