class Checkin < ActiveRecord::Base
  attr_accessible :pet_id, :place_id, :user_id, :wayd

  belongs_to :place
  belongs_to :user

  validates :wayd, presence: true,
            length: { minimum: 5 }

end
