# -*- encoding: utf-8 -*-

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate           # ログイン認証
  before_filter :reset_session_expires  # セッション有効期限延長

  private

  # ログイン認証
  def authenticate
    unless signed_in?
      # リクエストURL保管
      session[:request_url] = request.url

      # ルートヘリダイレクト
      redirect_to :root and return
    end
  end

  # セッション期限延長
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  # ログインユーザ
  def current_user
    @current_user ||= User.where( id: session[:user_id] ).first
  end
  helper_method :current_user

  # ユーザ登録チェック
  def signed_in?
    User.where( id: session[:user_id] ).exists?
  end
  helper_method :signed_in?
  
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

  def breadcrumb
    template = <<-"EOS"
        <ul class="breadcrumb">
          <li class="active">Home</li>
        </ul>
    EOS
  end
  helper_method :breadcrumb


  private if Rails.env != "development"

  def breadcrumb_base( module_name )
    template = <<-"EOS"
          <ul class="breadcrumb">
            <li><a href="/">Home</a> <span class="divider">/</span></li>
            <li>#{module_name.camelize} <span class="divider">/</span></li>
            <li>#{controller_name.camelize} <span class="divider">/</span></li>
          <li class="active">#{action_name.camelize}</li>
          </ul>
    EOS
  end

  def get_connection( domain )
    connection = Faraday::Connection.new( :url => domain ) do |builder|
      builder.use Faraday::Request::UrlEncoded
      # builder.use Faraday::Response::Logger
      builder.use Faraday::Adapter::NetHttp
    end
    connection
  end

end
