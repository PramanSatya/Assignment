class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :phone_number, presence: true, uniqueness: true

  before_create :tokenize

  private
    def tokenize
      self.token = SecureRandom.uuid
    end
end
