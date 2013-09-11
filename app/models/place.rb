class Place < ActiveRecord::Base
  attr_accessible :category, :city, :country, :gmaps, :latitude, :longitude, :name, :street, :description

  validates :description, presence: true, length: { maximum: 250 };

  has_many :reviews
  has_many :checkins

  acts_as_gmappable
  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.street}, #{self.city}, #{self.country}"
  end

  def self.search(name, cat)
    if !cat.blank? && !name.blank?
      self.where("UPPER(name) = UPPER(?) AND UPPER(category) = UPPER(?)", name, cat)
    elsif !cat.blank?
      where("UPPER(category) = UPPER(?)",cat)
    elsif !name.blank?
      where("UPPER(name) = UPPER(?)",name)
    else
      scoped # return an empty result set
    end
  end

end