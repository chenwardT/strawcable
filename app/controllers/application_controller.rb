class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    super || guest_user
  end

  def user_signed_in?
    current_user.registered?
  end

  def create_session_if_none
    if session[:id]
      puts "Session found: #{session[:id]}"
    else
      create_session
      puts "No session found, created session: #{session[:id]}"
    end
  end

  def registered?
    true
  end

  private

  def create_session
    session[:id] = ActionDispatch::Compatibility.generate_sid
  end

  def guest_user
    @guest ||= Guest.new(cookies.signed)
  end

end
