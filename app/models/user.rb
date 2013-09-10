class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :pets, :dependent => :destroy

  has_many :followed_pets, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  has_many :reviews
  has_many :checkins

  has_secure_password

  # put the email in downcase before saving the user
  before_save { |user| user.email = email.downcase }
  # call the create_remember_token private method before saving the user
  before_save :create_remember_token

  # name must be always present and with a maximum length of 50 chars
  validates :name, presence: true, length: { maximum: 50 };

  # email allowed format representation (expressed as a regex)
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i

  # email must be always present, unique and with a specific format
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  # password must be always present, and with a minimum length of 6 chars
  validates :password, presence: true, length: { minimum: 6 }

  # password_confirmation must be always present
  validates :password_confirmation, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def follow!(pet)
    relationships.create!(followed_id: pet.id, follower_id: id)
  end

  def unfollow!(pet)
    relationships.find_by_followed_id(pet).destroy
  end

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Pet.where("user_id = ?", id)
  end

  def following?(pet)
    followed_pets.include?(pet)
  end



  # private methods
  private
  def create_remember_token
    # create a random string, safe for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
