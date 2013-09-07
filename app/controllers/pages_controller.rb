class PagesController < ApplicationController
  def home
    if signed_in?
      @user= current_user
      @pet  = current_user.pets.build
      @feed_items = current_user.feed
    end
  end

  def about
  end

  def contact
  end

  def faq
  end
end
