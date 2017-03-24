class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :logged_in

  def current_user
    if session[:type_id] == 'borrower'
      Borrower.find(session[:user_id]) if session[:user_id]
    elsif session[:type_id] == 'lender'
      Lender.find(session[:user_id]) if session[:user_id]
    end
  end
  helper_method :current_user
  private
    def logged_in
      if !session[:user_id]
        redirect_to '/'
      end
    end
end
