require 'rails_helper' 
  
describe 'Usuário busca por um pedido' do 
  it 'a partir do menu' do 
    #arrange
    user = User.create(name: 'Joao', email: 'joao@email.com', password: 'password')
      #act
    login_as(user)
    visit root_path
    #assert
    within('header nav') do 
      expect(page).to have_field('Buscar Pedido')
      expect(page).to have_button('Buscar')
    end
  end

  it  'e deve estar autenticado' do 
    #arrange

    #act
    visit root_path

    #assert
    within('header nav') do 
      expect(page).not_to have_field('Buscar Pedido')
      expect(page).not_to have_button('Buscar')
    end
  end

  it 'e encontra um pedido' do 
    #arrange
    user = User.create(name: 'Joao', email: 'joao@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Aeroporto SP', 
    code:'GRU', city: 'São Paulo', area: 100_000,
    address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
    description: 'Galpão destinado para cargas internacionais')
    
    supplier = Supplier.create!(corporate_name:'ACME LTDA',
    brand_name: 'ACME', registration_number:'4344721600765', 
    full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
    email: 'contato@acme.com')

    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    #act
    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    #assert
    expect(page).to have_content "Resultado da Busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).to have_content "Fornecedor: ACME LTDA"
  end

  it 'e encontra múltiplos pedidos' do 
    #arrange
    user = User.create(name: 'Joao', email: 'joao@email.com', password: 'password')
    
    first_warehouse = Warehouse.create!(name: 'Aeroporto SP', 
      code:'GRU', city: 'São Paulo', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')

    second_warehouse = Warehouse.create!(name: 'Aeroporto RIO', 
        code:'SDU', city: 'Rio de Janeiro', area: 100_000,
        address: 'Avenida do Porto, 80', cep: '25000-000',
        description: 'Galpão destinado para cargas internacionais')
      
    supplier = Supplier.create!(corporate_name:'ACME LTDA',
      brand_name: 'ACME', registration_number:'4344721600765', 
      full_address:'Av das Palmas, 100', city:'Bauru', state:'SP', 
      email: 'contato@acme.com')

   allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98765')
    first_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00000')
    order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

  #act

  login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'

    #assert
    expect(page).to have_content('2 pedidos encontrados')
    expect(page).to have_content('GRU12345')
    expect(page).to have_content('GRU98765')
    expect(page).to have_content "Galpão Destino: GRU - Aeroporto SP"
    expect(page).not_to have_content('SDU00000')
    expect(page).not_to have_content "Galpão Destino: SDU - Aeroporto Rio"
  end
end