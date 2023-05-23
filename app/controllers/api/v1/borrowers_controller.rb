class Api::V1::BorrowersController < ApplicationController
  before_action :set_borrower, only: %i[show]
  before_action :set_invoices, only: %i[show]

  def index
    borrowers = Borrower.all.order(created_at: :desc)
    render json: borrowers
  end

  def create
    borrower = Borrower.create!(borrower_params)
    if borrower
      render json: borrower
    else
      render json: { error_message: "Error in creating borrower." }
    end
  end

  def show
    render json: { borrower: @borrower, invoices: @invoices }
  end

  private

  def borrower_params
    params.permit(:name)
  end

  def set_borrower
    @borrower = Borrower.find(params[:id].to_i)
  end

  def set_invoices
    @invoices = Invoice.select(:number).where(borrower_id: params[:id]).order(created_at: :desc)
  end
end
