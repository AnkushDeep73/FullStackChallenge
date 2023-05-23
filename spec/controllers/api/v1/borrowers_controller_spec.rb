RSpec.describe Api::V1::BorrowersController, type: :controller do
  describe 'POST #create' do
    context 'when borrower does not save to database' do
      it 'renders the page with error' do
        borrower = Borrower.new(name: "Test Name")
        params = ActionController::Parameters.new(name: borrower.name).permit(:name)
        allow(Borrower).to receive(:create!)
            .with(params)
            .and_return(nil)
  
        post :create, params: { name: borrower.name }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')
        
        json_body = JSON.parse(response.body)
        expect(json_body["error_message"]).to include("Error")
      end
    end
  
    context 'when borrower saves to database' do
      it 'creates the borrower' do
        borrower = Borrower.new(name: "Test Name")
        params = ActionController::Parameters.new(name: borrower.name).permit(:name)
        allow(Borrower).to receive(:create!)
            .with(params)
            .and_return(borrower)
  
        post :create, params: { name: borrower.name }
    
        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["name"]).to include(borrower.name)
      end
    end
  end

  describe 'GET #index' do
    context 'when index page is opened' do
      it 'lists all borrowers' do
        borrower_one = Borrower.new(name: "Test Name 1")
        borrower_two = Borrower.new(name: "Test Name 2")
        borrower_list = [borrower_one, borrower_two]

        allow(Borrower).to receive_message_chain(:all, :order)
            .with(created_at: :desc)
            .and_return(borrower_list)

        get :index

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body[0]["name"]).to include(borrower_one.name)
        expect(json_body[1]["name"]).to include(borrower_two.name)
      end
    end
  end

  describe 'GET #show' do
    context 'when show page is opened' do
      it 'shows the borrower and related invoices' do
        borrower = Borrower.create(name: "Test Name")

        allow(Borrower).to receive(:find)
            .with(borrower.id)
            .and_return(borrower)

        invoice_one = Invoice.new(borrower_id: borrower.id, number: "Test Number 1", amount: 100.00, due_date: "12/12/2023", status: "CREATED")
        invoice_two = Invoice.new(borrower_id: borrower.id, number: "Test Number 2", amount: 100.00, due_date: "12/12/2023", status: "PURCHASED")
        invoice_list = [invoice_one, invoice_two]

        allow(Invoice).to receive_message_chain(:select, :where, :order)
            .with(:number)
            .with(borrower_id: borrower.id)
            .with(created_at: :desc)
            .and_return(invoice_list)

        get :show, params: { id: borrower.id }

        expect(response).to have_http_status(:ok)
        expect(response.header['Content-Type']).to include('application/json')

        json_body = JSON.parse(response.body)
        expect(json_body["borrower"]["name"]).to include(borrower.name)
        expect(json_body["invoices"][0]["number"]).to include(invoice_one.number)
        expect(json_body["invoices"][1]["number"]).to include(invoice_two.number)
      end
    end
  end
end