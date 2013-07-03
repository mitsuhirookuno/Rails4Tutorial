class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # before_filter :authenticate
  
  # rescue_from RailsSandbox::HttpStatusError, :with => :http_status_error
  
  def http_status_error(exception = nil)
    if exception.presence
      render( :status => exception.status_code, :text => exception.message )
    end
  end
  
  #def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end
  
  #def login?
  #  current_user.presence
  #end
  
  #helper_method :current_user, :login?, :respond_to_model
  
  #def authenticate
  #  if request.fullpath.match(/^\/top/)
  #    if login?.blank?
  #      redirect_to '/sessions'
  #    else
  #      logger.info('login')
  #    end
  #  end
  #end
  
end
