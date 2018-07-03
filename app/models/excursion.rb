require 'csv'

class Excursion < ActiveRecord::Base
  has_many :registrations

  validates :name, presence: true, length: { minimum: 4, maximum: 50 }, format: { with: /\A[A-Za-z\séèóòàáíúñç\']+\z/, message: I18n.t('models.errors.invalid_characters') }
  validates :busSpots, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :lunchSpots, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}

  def to_csv(options = {})
    attributes = %w{name phoneNumber email busSpots lunchSpots}
    CSV.generate(options) do |csv|
      registration_column_names = attributes

      csv << registration_column_names

      self.registrations.each do |registration|
        csv << registration.attributes.values_at(*registration_column_names)
      end
    end
  end

end
