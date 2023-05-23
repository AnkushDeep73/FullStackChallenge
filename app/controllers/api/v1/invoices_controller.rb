class Api::V1::InvoicesController < ApplicationController
  STATUSES = {created: "CREATED", rejected: "REJECTED", approved: "APPROVED", purchased: "PURCHASED", closed: "CLOSED"}

  before_action :set_borrower, only: %i[create show approve reject purchase close]
  before_action :set_invoice, only: %i[show approve reject purchase close]

  def create
    params[:status] = STATUSES[:created]

    invoice = Invoice.create!(invoice_params)
    if invoice
      render json: invoice
    else
      render json: { error_message: "Error in creating invoice." }
    end
  end

  def approve
    unless @invoice.status.eql? STATUSES[:created]
      render json: { error_message: "Only CREATED invoices can be APPROVED." } and return
    end
    @invoice.update(status: STATUSES[:approved])
    render json: { borrower: @borrower, invoice: @invoice }
  end

  def reject
    unless @invoice.status.eql? STATUSES[:created]
      render json: { error_message: "Only CREATED invoices can be REJECTED." } and return
    end
    @invoice.update(status: STATUSES[:rejected])
    render json: { borrower: @borrower, invoice: @invoice }
  end

  def purchase
    unless @invoice.status.eql? STATUSES[:approved]
      render json: { error_message: "Only ARPPVOED invoices can be PURCHASED." } and return
    end
    @invoice.update(status: STATUSES[:purchased])
    render json: { borrower: @borrower, invoice: @invoice }
  end

  def close
    unless @invoice.status.eql? STATUSES[:purchased]
      render json: { error_message: "Only PURCHASED invoices can be CLOSED." } and return
    end
    @invoice.update(status: STATUSES[:closed])
    render json: { borrower: @borrower, invoice: @invoice }
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
