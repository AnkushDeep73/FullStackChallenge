class Api::V1::InvoicesController < ApplicationController
  STATUSES = {created: "CREATED", rejected: "REJECTED", approved: "APPROVED", purchased: "PURCHASED", closed: "CLOSED"}

  before_action :set_borrower, only: %i[create show]
  before_action :set_invoice, only: %i[show]

  def create
    params[:status] = STATUSES[:created]

    invoice = Invoice.create!(invoice_params)
    if invoice
      render json: invoice
    else
      render json: { error_message: "Error in creating invoice." }
    end
  end

  def show
    render json: { borrower: @borrower, invoice: @invoice }
  end

  private

  def invoice_params
    params[:borrower_id] = params[:borrower_id].to_i
    params[:amount] = params[:amount].to_d
    params[:due_date] = params[:due_date].to_date

    params.permit(:borrower_id, :number, :amount, :due_date, :status, :scan)
  end

  def set_borrower
    @borrower = Borrower.find(params[:borrower_id].to_i)
  end

  def set_invoice
    @invoice = Invoice.find(params[:id].to_i)
  end
end
