RSpec.describe Api::V1::InvoicesController, type: :controller do
  describe 'POST #create' do
    context 'when invoice does not save to database' do
      it 'renders the page with error' do
        borrower = Borrower.create(name: "Test Name")
          
        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.new(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "CREATED")
        params = ActionController::Parameters.new(
                borrower_id: invoice.borrower_id,
                number: invoice.number,
                amount: invoice.amount,
                due_date: invoice.due_date,
                status: invoice.status)
            .permit(:borrower_id, :number, :amount, :due_date, :status, :scan)
        allow(Invoice).to receive(:create!)
            .with(params)
            .and_return(nil)
      
        post :create, params: {
                borrower_id: invoice.borrower_id,
                number: invoice.number,
                amount: invoice.amount,
                due_date: invoice.due_date,
                status: invoice.status }
    
        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')
  
        json_body = JSON.parse(response.body)
        expect(json_body["error_message"]).to include("Error")
      end
    end

    context 'when invoice saves to database' do
      it 'creates the invoice' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.new(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "CREATED")
        params = ActionController::Parameters.new(
                borrower_id: invoice.borrower_id,
                number: invoice.number,
                amount: invoice.amount,
                due_date: invoice.due_date,
                status: invoice.status)
            .permit(:borrower_id, :number, :amount, :due_date, :status, :scan)
        allow(Invoice).to receive(:create!)
            .with(params)
            .and_return(invoice)

        post :create, params: {
                borrower_id: invoice.borrower_id,
                number: invoice.number,
                amount: invoice.amount,
                due_date: invoice.due_date,
                status: invoice.status }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["number"]).to include(invoice.number)
      end
    end
  end

  describe 'GET #show' do
    context 'when index page is opened' do
      it 'lists all invoices' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "CREATED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        get :show, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["borrower"]["name"]).to include(borrower.name)
        expect(json_body["invoice"]["number"]).to include(invoice.number)
      end
    end
  end
end