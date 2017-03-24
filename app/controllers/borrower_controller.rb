class BorrowerController < ApplicationController
  before_action :borrowerconfirm
  before_action :properpage

  def show
    @lenders = History.where(borrower_id: current_user.id)
    @lent = @lenders.sum(:amount)
  end

  private
    def borrowerconfirm
      if session[:type_id] != 'borrower'
        redirect_to "/lender/#{current_user.id}"
      end
    end
    def properpage
      if params[:id] != current_user.id.to_s
        redirect_to "/borrower/#{current_user.id}"
      end
    end
end
