module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    # self is mandatory to tell Rails that current_user is a method already defined and not a variable to be created
    self.current_user = user
  end

  # Set the user performing the sign in as the current user
  #
  # user - The User to be used as current user in the session
  def current_user=(user)
    @current_user = user
  end

  # Get the user corresponding to the remember token (taken from the permanent cookie)
  # only if the current_user instance variable is undefined
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

  # Check if the current user is signed in
  def signed_in?
    !current_user.nil?
  end

  # Perform the sign out of the current user, by clearing the current user instance variable
  # and deleting the corresponding cookie
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  # Check if the given user is also the current user (for authorization purposes)
  #
  # user - The User to check the authorization for
  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

end
