class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def ensure_logged_in
    unless logged_in?
      flash[:alert] = "Please log in."
      redirect_to :signin
    end
  end

end
