class ApplicationController < ActionController::Base
  # protect_from_forgery

  respond_to  :html,:json
  #protect_from_forgery #with: :exception
  #before_action :configure_permitted_parameters, if: :devise_controller?

  after_filter :set_csrf_cookie_for_ng
  def angularHome
   render 'layouts/navbar'
    #render :nothing => true
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)
  end

end
