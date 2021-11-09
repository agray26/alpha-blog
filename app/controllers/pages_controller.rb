class PagesController < ActionController::Base
  layout 'application'
  
  #=====================================================================================================================================
  # I shouldnt need these here because they are declared in application_controller
  # but for some reason that all the 10 year old stack overflow posts in the world cannot help me determine why
  helper_method :current_user, :logged_in?
  def current_user
    # create an instance variable of current_user so every time we use the currentuser method we dont hit the database
    # the line below says if the session[:user_id] exists and is not nill then we want to get the user object
    # belonging to that user from the user database
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    !!current_user
  end
 #========================================================================================================================================


  def home
    redirect_to articles_path if logged_in?
    # respond_to do |format|
    #   format.html { render :home }
    # end
  end

  def about
  end
end