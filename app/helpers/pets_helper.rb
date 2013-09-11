module PetsHelper
  def popularity
    @int = @pet.follower_users.count*10
  end
end
