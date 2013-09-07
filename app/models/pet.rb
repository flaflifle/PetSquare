class Pet < ActiveRecord::Base
  attr_accessible :breed, :description, :namePet
  #serve relazione utente può avere più animale
  belongs_to :user
  validates :user_id, presence: true

  has_many :follower_users, through: :relationships, source: :follower
  has_many :relationships, foreign_key: "followed_id", dependent: :destroy

  validates :namePet, presence: true, length: { maximum: 50 };
  validates :breed, presence: true, length: { maximum: 50 };
  validates :description, presence: true, length: { maximum: 50 };

end
