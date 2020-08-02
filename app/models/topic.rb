class Topic < ApplicationRecord
  # リレーション
  belongs_to :user
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  has_many :comments
  has_many :comments_users, through: :comments, source: 'user'

  # バリデーション
  validates :user_id, presence: true
  validates :description, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
