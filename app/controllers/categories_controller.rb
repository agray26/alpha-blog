class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]

  layout 'application'
  
  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def show
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully created"
      redirect_to @category
    else
      render 'new'
    end
  end

  private 

  def category_params
    params.require(:category).permit(:name)
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

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can perform that action"
      redirect_to categories_path
    end
  end

end