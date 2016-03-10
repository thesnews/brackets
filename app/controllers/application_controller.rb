class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
    authenticate_user!
    unless current_user.admin?
      respond_to do |format|
        format.html do
          redirect_to :root
        end
        format.json do
          head :unauthorized
        end
      end
    end
  end
end
