class Borrower < ApplicationRecord
  has_many :invoices

  validates :name, presence: true
end
