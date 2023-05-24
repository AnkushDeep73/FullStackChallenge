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

  describe 'POST #approve' do
    context 'when invoice status is CREATED and approve is called' do
      it 'invoice status is updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "CREATED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :approve, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["borrower"]["name"]).to include(borrower.name)
        expect(json_body["invoice"]["number"]).to include(invoice.number)
        expect(json_body["invoice"]["status"]).to include("APPROVED")
      end
    end

    context 'when invoice status is not CREATED and approve is called' do
      it 'invoice status is not updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "APPROVED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :approve, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["error_message"]).to include("Only CREATED invoices can be APPROVED")
      end
    end
  end

  describe 'POST #reject' do
    context 'when invoice status is CREATED and reject is called' do
      it 'invoice status is updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "CREATED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :reject, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["borrower"]["name"]).to include(borrower.name)
        expect(json_body["invoice"]["number"]).to include(invoice.number)
        expect(json_body["invoice"]["status"]).to include("REJECTED")
      end
    end

    context 'when invoice status is not CREATED and reject is called' do
      it 'invoice status is not updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "APPROVED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :reject, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["error_message"]).to include("Only CREATED invoices can be REJECTED")
      end
    end
  end

  describe 'POST #purchase' do
    context 'when invoice status is APPROVED and purchase is called' do
      it 'invoice status is updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "APPROVED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :purchase, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["borrower"]["name"]).to include(borrower.name)
        expect(json_body["invoice"]["number"]).to include(invoice.number)
        expect(json_body["invoice"]["status"]).to include("PURCHASED")
      end
    end

    context 'when invoice status is not APPROVED and purchase is called' do
      it 'invoice status is not updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "CREATED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :purchase, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["error_message"]).to include("Only APPROVED invoices can be PURCHASED")
      end
    end
  end

  describe 'POST #close' do
    context 'when invoice status is PURCHASED and close is called' do
      it 'invoice status is updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "PURCHASED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :close, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["borrower"]["name"]).to include(borrower.name)
        expect(json_body["invoice"]["number"]).to include(invoice.number)
        expect(json_body["invoice"]["status"]).to include("CLOSED")
      end
    end

    context 'when invoice status is not PURCHASED and close is called' do
      it 'invoice status is not updated' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice = Invoice.create(borrower_id: borrower.id, number: "Test Number", amount: 100.00, due_date: "12/12/2023", status: "APPROVED")

        allow(Invoice).to receive(:find)
            .with(invoice.id)
            .and_return(invoice)

        post :close, params: {
            borrower_id: invoice.borrower_id,
            id: invoice.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["error_message"]).to include("Only PURCHASED invoices can be CLOSED")
      end
    end
  end
end