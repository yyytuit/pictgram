class Topic < ApplicationRecord
  # リレーション
  belongs_to :user

  # バリデーション
  validates :user_id, presence: true
  validates :description, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
