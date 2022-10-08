require 'rails_helper'

describe 'Usuário vê o estoque' do 
  it 'na tela do galpão' do
  #arrange
  user = User.create!(name: 'Sarah', email:  'sarah@email.com', password: 'password')
  w = Warehouse.create(name: 'Aeroporto SP', code:'GRU', city: 'São Paulo', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

  supplier = Supplier.create(brand_name:'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'0984562341984', full_address:'Av Nacoes Unidas, 1000' , city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')  

  order = Order.create!(user: user, supplier: supplier, warehouse: w, estimated_delivery_date: 1.day.from_now)

  produto_tv = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth:10, sku:'TV 32-SAMSU-XPT090', supplier: supplier)

  produto_soundbar = ProductModel.create!(name:'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)

  produto_notebook = ProductModel.create!(name:'Notebook i5 16GB RAM', weight: 2000, width: 40, height: 9, depth: 20, sku: 'NOTEI5-SAMSU-NOTLI99', supplier: supplier)

  3.times{ StockProduct.create!(order: order, warehouse: w, product_model: produto_tv)}
  2.times{ StockProduct.create!(order: order, warehouse: w, product_model: produto_notebook)}

  #act
  login_as user
  visit root_path
  click_on 'Aeroporto SP'

   
  #assert
  expect(page).to have_content 'Itens em Estoque'
  expect(page).to have_content '3 x TV 32-SAMSU-XPT090'
  expect(page).to have_content '2 x NOTEI5-SAMSU-NOTLI99'
  expect(page).not_to have_content 'SOU71-SAMSU-NOIZ77'
  end
end