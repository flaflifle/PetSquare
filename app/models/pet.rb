class Pet < ActiveRecord::Base
  attr_accessible :breed, :description, :namePet
  #serve relazione utente può avere più animale
  belongs_to :user
  validates :user_id, presence: true

  has_many :checkins

  has_many :follower_users, through: :relationships, source: :follower
  has_many :relationships, foreign_key: "followed_id", dependent: :destroy

  validates :namePet, presence: true, length: { maximum: 50 };
  validates :breed, presence: true, length: { maximum: 50 };
  validates :description, presence: true, length: { maximum: 50 };

  def self.search(user_pet)
    if user_pet
      where('breed LIKE ?', "%#{user_pet}%")
    else
      scoped # return an empty result set
    end
  end

=begin
  def self.popularity(pet)
    if pet
      where('followed_id= ? GROUP BY followed_id', "%#{pet}")
    end
  end
=end

end
