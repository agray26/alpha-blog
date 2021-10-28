class PagesController < ActionController::Base
  layout 'application'

  def home
    respond_to do |format|
      format.html { render :home }
    end
  end

  def about
  end
end