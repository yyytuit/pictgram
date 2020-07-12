class User < ApplicationRecord
  # 定数
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)(?=.*?[A-Z])[a-zA-Z\d]{8,32}\z/
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # 外部装備
  has_secure_password

  # リレーション
  has_many :topics

  # バリデーション
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX }
end
