require 'user_sanitizer'
require 'guide_sanitizer'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    elsif resource_class == Guide
      Guide::ParameterSanitizer.new(Guide, :guide, params)
    # elsif resource_class == Admin
    #   Admin::ParameterSanitizer.new(Admin, :admin, params)
    else
      super # Use the default one
    end
  end
  def after_sign_in_path_for(admin)
    rails_admin_path
  end
end
