require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do 
 it 'e deve estar atenticado' do 
  #arrange

  #act
  visit root_path
  click_on 'Meus Pedidos'

  #assert
  expect(current_path).to eq new_user_session_path
 end


it 'e não vê outros pedidos' do 
  #arrange
  joao = User.create(name: 'Joao', email: 'joao@email.com', password: 'password')

  maria = User.create(name: 'Maria', email: 'maria@email.com', password: 'password')
  warehouse = Warehouse.create!(name: 'Aeroporto SP', 
  code:'GRU', city: 'São Paulo', area: 100_000,
  address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
  description: 'Galpão destinado para cargas internacionais')

  supplier = Supplier.create!(corporate_name:'ACME LTDA',
  brand_name: 'ACME', registration_number:'4344721600765', 
  full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
  email: 'contato@acme.com')

  first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'pending')

  second_order = Order.create!(user: maria, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now, status: 'delivered')

  third_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now, status: 'canceled')

  #act
  login_as(joao)
  visit root_path
  click_on 'Meus Pedidos'
  
  #assert
  expect(page).to have_content first_order.code
  expect(page).to have_content 'Pendente'
  expect(page).not_to have_content second_order.code
  expect(page).not_to have_content 'Entregue'
  expect(page).to have_content third_order.code
  expect(page).to have_content 'Cancelado'
 end

 it 'e visita um pedido' do 
  #arrange
  joao = User.create(name: 'Joao', email: 'joao@email.com', password: 'password')

  warehouse = Warehouse.create!(name: 'Aeroporto SP', 
    code:'GRU', city: 'São Paulo', area: 100_000,
    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
    description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name:'ACME LTDA',
      brand_name: 'ACME', registration_number:'4344721600765', 
      full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
      email: 'contato@acme.com')

  first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

  #act
  login_as(joao)
  visit root_path
  click_on 'Meus Pedidos'
  click_on first_order.code

  #assert
  expect(page).to have_content 'Detalhes do Pedido'
  expect(page).to have_content first_order.code
  expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
  expect(page).to have_content 'Fornecedor: ACME LTDA'
  formatted_date = I18n.localize(1.day.from_now.to_date)
  expect(page).to have_content "Data Prevista de Entrega: #{formatted_date}"
 end

  it  'e não visita pedidos de outros usuários' do 
    andre = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', 
      code:'GRU', 
      city: 'São Paulo', 
      area: 100_000,
      address: 'Avenida do Aeroporto, 1000', 
      cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name:'ACME LTDA',
      brand_name: 'ACME', 
      registration_number:'4344721600765', 
      full_address:'Av das Palmas, 100', 
      city:'Bauru', 
      state:'SP', 
      email: 'contato@acme.com')

    first_order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    #act
    login_as(andre)
    visit order_path(first_order.id)

    #assert
    expect(current_path).not_to eq order_path(first_order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido.'
  end

  it 'e vê itens do pedido' do 
     #arrange
     supplier = Supplier.create!(corporate_name:'ACME LTDA',
      brand_name: 'ACME', registration_number:'4344721600765', 
      full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
      email: 'contato@acme.com')

      product_a = ProductModel.create!(name: 'Produto A', weight: 15, width: 10,  height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOA')

      product_b = ProductModel.create!(name: 'Produto B', weight: 15, width: 10,  height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOB')

      product_c = ProductModel.create!(name: 'Produto C', weight: 15, width: 10,  height: 20, depth: 30, supplier: supplier, sku: 'PRODUTOC')

     joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
     warehouse = Warehouse.create!(name: 'Aeroporto SP', 
     code:'GRU', city: 'São Paulo', area: 100_000,
     address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
     description: 'Galpão destinado para cargas internacionais')
     order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)


     OrderItem.create!(product_model: product_a, order: order, quantity: 19)
     OrderItem.create!(product_model: product_b, order: order, quantity: 12)
     #act
     login_as joao
     visit root_path
     click_on 'Meus Pedidos'
     click_on order.code
     #assert
      expect(page).to have_content 'Itens do Pedido'
      expect(page).to have_content '19 x Produto A'
      expect(page).to have_content '12 x Produto B'
   end
  end