class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true

  validates :brand_name, uniqueness: true
  validates :registration_number, uniqueness: true, length: { maximum: 13 }
end
