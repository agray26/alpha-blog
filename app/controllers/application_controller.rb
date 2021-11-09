class ApplicationController < ActionController::Base

    helper_method :current_user, :logged_in?, :require_user

    def current_user
      # create an instance variable of current_user so every time we use the currentuser method we dont hit the database
      # the line below says if the session[:user_id] exists and is not nill then we want to get the user object
      # belonging to that user from the user database
      @current_user ||= User.find(session[:user_id]) if session[:user_id] 
    end

    def logged_in?
      !!current_user
    end

    def require_user
      if !logged_in?
        flash[:alert] = "You must be logged in to perform that action"
        redirect_to login_path
      end
    end
end
