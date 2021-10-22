class PagesController < ActionController::Base
    def home
      respond_to do |format|
        format.html { render :home }
      end
    end

    def about
    end
end