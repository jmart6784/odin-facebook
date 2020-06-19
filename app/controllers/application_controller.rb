class ApplicationController < ActionController::Base
  # For Post Show likes only
  def like_text
    if @like_exists == true
      "Unlike"
    else
      "Like"
    end
  end

  # For Post Show likes only
  def like_count_text
    @post = Post.find(params[:id]).likes.count
  end

  helper_method :like_text, :like_count_text

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :avatar, :bio])
  end
end
