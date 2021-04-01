# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_many :active_relationships, class_name: 'RelationshipBetweenUser', foreign_key: 'follower_id', dependent: :destroy, inverse_of: :follower
  has_many :following, through: :active_relationships, source: :following
  has_many :passive_relationships, class_name: 'RelationshipBetweenUser', foreign_key: 'following_id', dependent: :destroy, inverse_of: :following
  has_many :followers, through: :passive_relationships, source: :follower

  has_one_attached :avatar

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def follow(other_user)
    active_relationships.find_or_create_by!(following_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(following_id: other_user.id).destroy
  end

  def following?(other_user)
    active_relationships.where(following_id: other_user.id).exists?
  end
end
