require 'rails_helper' 

describe  'usuário edita pedido' do 
  it 'e deve estar autenticado' do
#arrange
joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

warehouse = Warehouse.create!(name: 'Aeroporto SP', 
code:'GRU', city: 'São Paulo', area: 100_000,
address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
description: 'Galpão destinado para cargas internacionais')

supplier = Supplier.create!(corporate_name:'ACME LTDA',
brand_name: 'ACME', registration_number:'4344721600765', 
full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
email: 'contato@acme.com')

order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
  #act
  visit edit_order_path(order.id)
  #assert
  expect(current_path).to eq new_user_session_path
  end
  
  it 'com sucesso' do 
    #arrange
    joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', 
    code:'GRU', city: 'São Paulo', area: 100_000,
    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
    description: 'Galpão destinado para cargas internacionais')

    supplier = Supplier.create!(corporate_name:'ACME LTDA',
    brand_name: 'ACME', registration_number:'4344721600765', 
    full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
    email: 'contato@acme.com')

    Supplier.create!(corporate_name: 'SIB-LTDA', brand_name: 'SIB', registration_number:'445464748', full_address:'Torre de Indústrias, 45', city:'Teresina', state: 'PI', email: 'contato@sib.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    #act
    login_as(joao)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on  'Editar'
    fill_in  'Data Prevista de Entrega', with: '12/12/2022'
    select 'SIB-LTDA', from: 'Fornecedor'
    click_on 'Gravar'
    #assert
    expect(page).to have_content 'Pedido atualizado com sucesso.'
    expect(page).to have_content 'Fornecedor: SIB-LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2022'
    end

    it 'caso seja o responsável' do
      #arrange
      andre = User.create!(name: 'Andre', email: 'andre@email.com', password: 'password')
      joao = User.create!(name: 'Joao', email: 'joao@email.com', password: 'password')
      
      warehouse = Warehouse.create!(name: 'Aeroporto SP', 
      code:'GRU', city: 'São Paulo', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')
      
      supplier = Supplier.create!(corporate_name:'ACME LTDA',
      brand_name: 'ACME', registration_number:'4344721600765', 
      full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
      email: 'contato@acme.com')
      
      order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
        #act
        login_as(andre)
        visit edit_order_path(order.id)
        #assert
        expect(current_path).to eq root_path
        end
     end
