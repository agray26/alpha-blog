module ApplicationHelper

  def gravatar_for(user, options = {size: 80})
    email_address = user.email.downcase
    has = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded shadow mx-auto d-block")
  end

  def current_user
    # create an instance variable of current_user so every time we use the currentuser method we dont hit the database
    # the line below says if the session[:user_id] exists and is not nill then we want to get the user object
    # belonging to that user from the user database
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    !!current_user
  end
end
