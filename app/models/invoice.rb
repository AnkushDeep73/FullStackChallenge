class Invoice < ApplicationRecord
  has_one_attached :image

  validates :number, presence: true
  validates :amount, presence: true
  validates :due_date, presence: true
  validates :status, presence: true
end
