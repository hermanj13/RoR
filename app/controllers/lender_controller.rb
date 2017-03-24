class LenderController < ApplicationController
  before_action :lenderconfirm
  skip_before_action :properpage, except: [:show]

  def show
    @need = Borrower.all
    @given = History.where(lender_id: current_user.id)
  end

  def lend
    if params[:amount].to_i > 0
      if current_user.money >= params[:amount].to_i
        if lending = History.find_by(lender_id: current_user.id, borrower_id: params[:id])
          lending.amount += params[:amount].to_i
          if lending.save
            borrow = Borrower.find(params[:id])
            borrow.raised += params[:amount].to_i
            borrow.save
            lend = Lender.find(current_user.id)
            update = lend.money - params[:amount].to_i
            lend.update(money: update)
            redirect_to "/lender/#{current_user.id}"
          else
            flash[:notice] = lending.errors.full_messages
            redirect_to "/lender/#{current_user.id}"
          end
        else
          lending = History.new(amount:params[:amount], lender_id: current_user.id, borrower_id: params[:id])
          if lending.save
            borrow = Borrower.find(params[:id])
            borrow.raised += params[:amount].to_i
            borrow.save
            lend = Lender.find(current_user.id)
            update = lend.money - params[:amount].to_i
            lend.update(money: update)
            redirect_to "/lender/#{current_user.id}"
          else
            flash[:notice] = lending.errors.full_messages
            redirect_to "/lender/#{current_user.id}"
          end
        end
      else
        flash[:notice] = ["Not enough money to do that!"]
        redirect_to "/lender/#{current_user.id}"
      end
    else
      flash[:notice] = ["Amount must be greater then 0!"]
      redirect_to "/lender/#{current_user.id}"
    end
  end

  private
    def lenderconfirm
      if session[:type_id] != 'lender'
        redirect_to "/borrower/#{current_user.id}"
      end
    end
    def properpage
      if params[:id] != current_user.id.to_s
        redirect_to "/lender/#{current_user.id}"
      end
    end
end
