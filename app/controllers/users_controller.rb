class UsersController < ActionController::Base
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  layout 'application'

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new 
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account information was successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)   
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Alpha Blog #{@user.username}!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy

    #log user out after destroy to keep error from happening
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

  private 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user 
    @user = User.find(params[:id])
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

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You cannot edit another user's profile"
      redirect_to @user
    end
  end
end