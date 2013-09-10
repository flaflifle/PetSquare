class Review < ActiveRecord::Base
  attr_accessible :body, :place, :user

  belongs_to :place
  belongs_to :user

  validates :body, presence: true,
            length: { minimum: 5 }
end
