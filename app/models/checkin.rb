class Checkin < ActiveRecord::Base
  attr_accessible :pet_id, :place_id, :user_id, :wayd

  belongs_to :place
  belongs_to :user
  belongs_to :pet

  default_scope -> { order('created_at DESC') }
  validates :wayd, presence: true,
            length: { minimum: 5 }

  def self.from_pets_followed_by(user)
  followed_pet_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
  where("pet_id IN (#{followed_pet_ids}) OR user_id = :user_id",
        user_id: user.id)
  end
end
