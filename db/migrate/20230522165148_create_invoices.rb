class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.belongs_to :borrower, null: false, index: true, foreign_key: true

      t.string :number, null: false
      t.decimal :amount, null: false
      t.date :due_date, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
