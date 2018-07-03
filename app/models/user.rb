class User < ActiveRecord::Base
  attr_accessor :reset_token
  before_save { email.downcase! }
  validates :name, presence: true, length: { minimum: 2 , maximum: 50}, format: { with: /\A[A-Za-z\séèóòàáíúñç\']+\z/, message: I18n.t('models.errors.invalid_characters') }
  validates :surname, presence: true, length: { minimum: 2, maximum: 100 }, format: { with: /\A[A-Za-z\séèóòàáíúñç\']+\z/, message: I18n.t('models.errors.invalid_characters') }
  validates :phoneNumber, presence: true, length: { is: 9 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence:true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_registration_confirmation(excursion, registration)
    UserMailer.registration_confirmation(self, excursion, registration).deliver_now
  end

end
