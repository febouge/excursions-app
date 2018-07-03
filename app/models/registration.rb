class Registration < ActiveRecord::Base
  belongs_to :excursion

  validates :name, presence: true, length: { minimum: 2, maximum: 50}, format: { with: /\A[A-Za-z\séèóòàáíúñç\']+\z/, message: I18n.t('models.errors.invalid_characters') }
  validates :phoneNumber, presence: true, length: { is: 9 }, numericality: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :busSpots, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :lunchSpots, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :coi, :acceptance => {:accept => true}
end
