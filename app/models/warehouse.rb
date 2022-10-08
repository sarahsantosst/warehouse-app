class Warehouse < ApplicationRecord
  validates :name, :code, :city, :description, :address, :cep, presence: true
  validates :code, uniqueness: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: "inválido" }
  has_many :stock_products

  def full_description
    "#{code} - #{name}"
  end
end
