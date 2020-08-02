class Comment < ApplicationRecord
  # リレーション
  belongs_to :user
  belongs_to :topic
  # バリデーション
  validates :user_id, presence: true
end
