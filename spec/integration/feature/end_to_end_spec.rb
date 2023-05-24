require 'rails_helper'

RSpec.describe 'End to end test', type: :feature, js: true do
  scenario 'Go To Home, Create Borrower, Go To Borrowers page, Go to newly created Borrower page, Create Invoice, Approve Invoice, Purchase Invoice, Close Invoice' do
    last_borrower = Borrower.where("name LIKE 'Integration Test Borrower%'").order(created_at: :desc).limit(1)
    unless last_borrower.empty?
      new_borrower_name_index = last_borrower[0].name.split('Integration Test Borrower')[1].to_i + 1
    else
      new_borrower_name_index = 0
    end

    visit '/'
    expect(page).to have_content("Lender Management Tool")

    click_on 'Create Borrower'
    expect(page).to have_content("Add a new borrower.")
    fill_in 'borrowerName', with: "Integration Test Borrower#{new_borrower_name_index}"
    click_on 'Create Borrower'
    expect(page).to have_content("Integration Test Borrower#{new_borrower_name_index}")
    expect(page).to have_content("No invoices yet.")
    
    visit '/borrowers'
    expect(page).to have_content("Integration Test Borrower#{new_borrower_name_index}")

    first('.card-body').click_link("View Borrower")
    expect(page).to have_content("No invoices yet.")

    click_on 'Create New Invoice'
    expect(page).to have_content("Add a new invoice.")
    fill_in 'invoiceNumber', with: "Integration Test Invoice"
    fill_in 'invoiceAmount', with: "499.99"
    fill_in 'invoiceDueDate', with: "12/12/2023"
    click_on 'Create Invoice'

    expect(page).to have_content("Integration Test Invoice")
    expect(page).to have_content("499.99")
    expect(page).to have_content("2023-12-12")
    expect(page).to have_content("CREATED")
    click_on 'Approve'
    expect(page).to_not have_content("APPROVED")
    check 'I authorize the Approval or Rejection of this Invoice.'
    click_on 'Approve'
    expect(page).to have_content("APPROVED")

    click_on 'Purchase'
    expect(page).to_not have_content("PURCHASED")
    check 'I authorize the Purchase of this Invoice.'
    click_on 'Purchase'
    expect(page).to have_content("PURCHASED")

    click_on 'Close'
    expect(page).to_not have_content("CLOSED")
    check 'I authorize the Closure of this Invoice.'
    click_on 'Close'
    expect(page).to have_content("CLOSED")
  end

  scenario 'Go To Home, Create Borrower, Go To Borrowers page, Go to newly created Borrower page, Create Invoice, Reject Invoice' do
    last_borrower = Borrower.where("name LIKE 'Integration Test Borrower%'").order(created_at: :desc).limit(1)
    unless last_borrower.empty?
      new_borrower_name_index = last_borrower[0].name.split('Integration Test Borrower')[1].to_i + 1
    else
      new_borrower_name_index = 0
    end

    visit '/'
    expect(page).to have_content("Lender Management Tool")

    click_on 'Create Borrower'
    expect(page).to have_content("Add a new borrower.")
    fill_in 'borrowerName', with: "Integration Test Borrower#{new_borrower_name_index}"
    click_on 'Create Borrower'
    expect(page).to have_content("Integration Test Borrower#{new_borrower_name_index}")
    expect(page).to have_content("No invoices yet.")
    
    visit '/borrowers'
    expect(page).to have_content("Integration Test Borrower#{new_borrower_name_index}")

    first('.card-body').click_link("View Borrower")
    expect(page).to have_content("No invoices yet.")

    click_on 'Create New Invoice'
    expect(page).to have_content("Add a new invoice.")
    fill_in 'invoiceNumber', with: "Integration Test Invoice"
    fill_in 'invoiceAmount', with: "499.99"
    fill_in 'invoiceDueDate', with: "12/12/2023"
    click_on 'Create Invoice'

    expect(page).to have_content("Integration Test Invoice")
    expect(page).to have_content("499.99")
    expect(page).to have_content("2023-12-12")
    expect(page).to have_content("CREATED")
    click_on 'Reject'
    expect(page).to_not have_content("REJECTED")
    check 'I authorize the Approval or Rejection of this Invoice.'
    click_on 'Reject'
    expect(page).to have_content("REJECTED")
  end
end