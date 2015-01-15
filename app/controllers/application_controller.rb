class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  # did this whilst testing APIs
  #def current_user
  #  return User.first 
  #end

  def validate_token_checked
    # check the key being passed in, or give an error message
  end

  def require_accessing_user
    if accessing_user.blank?
      redirect_to user_registrations_path
    end
  end

  def accessing_user
    current_user || User.user_for(params[:public_key])
  end
end
