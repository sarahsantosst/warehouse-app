require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'gera um número de série' do 

    it 'ao criar um StockProduct' do 
      #arrange
      user = User.create!(name: 'Sergio',
        email: 'sergio@email.com', password:'12345678') 
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address:'Endereço',
      cep:'25000-000', 
      city:'Rio', 
      area: 10000, 
      description: 'Alguma descriçao')
      supplier = Supplier.create!(corporate_name:'ACME LTDA',
      brand_name: 'ACME', 
      registration_number:'4344721600',
      full_address:'Av das Palmas, 100',
      city:'Bauru', 
      state: 'SP', 
      email: 'contato@acme.com')
      order = Order.create!(user: user, 
      warehouse: warehouse, supplier: supplier, estimated_delivery_date:  1.week.from_now)

     product = ProductModel.create!(name:'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80, sku: 'CGMER-XPTO-888')
      #act
     stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
     #assert
     expect(stock_product.serial_number.length).to eq 20
end

    it 'e não é modificado' do 
      user = User.create!(name: 'Sergio',
        email: 'sergio@email.com', password:'12345678') 
      warehouse = Warehouse.create!(name: 'Santos Dumont', code: 'RIO', address:'Endereço',
      cep:'25000-000', 
      city:'Rio', 
      area: 10000, 
      description: 'Alguma descriçao')
      other_warehouse = Warehouse.create!(name: 'Guarulhos', code: 'GRU', address:'Av Bandeirantes, 1000',
        cep:'35000-000', 
        city:'Guarulhos', 
        area: 10000, 
        description: 'Galpão de SP')
      supplier = Supplier.create!(corporate_name:'ACME LTDA',
      brand_name: 'ACME', 
      registration_number:'4344721600',
      full_address:'Av das Palmas, 100',
      city:'Bauru', 
      state: 'SP', 
      email: 'contato@acme.com')
      order = Order.create!(user: user, 
      warehouse: warehouse, supplier: supplier, estimated_delivery_date:  1.week.from_now)

     product = ProductModel.create!(name:'Cadeira Gamer', supplier: supplier, weight: 5, height: 70, width: 75, depth: 80, sku: 'CGMER-XPTO-888')
    
     stock_product = StockProduct.create!(order: order, warehouse: warehouse, product_model: product)
     original_serial_number = stock_product.serial_number
      #act
      stock_product.update(warehouse: other_warehouse)
     #assert
    expect(stock_product.serial_number).to eq original_serial_number
    end
  end
end
