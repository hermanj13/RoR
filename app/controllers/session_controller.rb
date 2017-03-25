class SessionController < ApplicationController
  skip_before_action :logged_in
  def login
  end

  def signup
  end

  def newuser
    if params[:type] == "Lender"
      user = Lender.new(first: params[:first],last: params[:last], email: params[:email],password: params[:password], password_confirmation: params[:password_confirmation],money: params[:money])
      if user.save
        login = Lender.find_by(email: params[:email])
        session[:user_id] = login.id
        session[:type_id] = "lender"
        redirect_to "/lender/#{login.id}"
      else
        flash[:notice] = user.errors.full_messages
        redirect_to '/register'
      end
    elsif params[:type] == "Borrower"
      user = Borrower.new(first: params[:first],last: params[:last], email: params[:email],password: params[:password], password_confirmation: params[:password_confirmation],money: params[:money],purpose: params[:purpose], description: params[:description], raised: 0)
      if user.save
        login = Borrower.find_by(email: params[:email])
        session[:user_id] = login.id
        session[:type_id] = "borrower"
        redirect_to "/borrower/#{login.id}"
      else
        flash[:notice] = user.errors.full_messages
        redirect_to '/register'
      end
    end
  end

  def create
    if params[:type] == "Lender"
        if user = Lender.find_by(email: params[:email])
        user = user.authenticate(params[:password])
        	if user
        		session[:user_id] = user.id
            session[:type_id] = "lender"
    				redirect_to "/lender/#{user.id}"
      		else
      			flash[:notice] = ["Invalid Password"]
      			redirect_to "/"
      		end
  		   else
      		flash[:notice] = ["Invalid Email"]
      		redirect_to "/"
  		   end
    elsif params[:type] == "Borrower"
        if user = Borrower.find_by(email: params[:email])
        user = user.authenticate(params[:password])
          if user
            session[:user_id] = user.id
            session[:type_id] = "borrower"
            redirect_to "/borrower/#{user.id}"
          else
            flash[:notice] = ["Invalid Password"]
            redirect_to "/"
          end
        else
          flash[:notice] = ["Invalid Email"]
          redirect_to "/"
        end
    end
  end

  def destroy
    reset_session
    session[:type_id] = nil
    redirect_to '/'
  end
end
