class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :games, dependent: :nullify
  has_many :players, dependent: :nullify

  before_validation :set_nickname, on: :create

  validates :nickname, presence: true, uniqueness: true

  private

  def set_nickname
    self.nickname ||= email.split("@").first if email.present?
  end
end
