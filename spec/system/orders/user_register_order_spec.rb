require 'rails_helper' 

describe 'Usuário cadastra um pedido' do
  it  'e deve estar autenticado' do 
    #arrange
    #act
    visit root_path
    click_on 'Registrar Pedido'
    #assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    #arrange
    user = User.create!(name: 'Sergio',
                        email: 'sergio@email.com', password:'12345678') 

    Warehouse.create!(name: 'Galpão Belo-Horizonte', 
                        code: 'BHZ', area: 20000, 
                        cep: '46000-000', city: 'Belo-Horizonte',
                        description: 'Galpão para cargas mineiras',
                        address: 'Av Tiradentes, 20')

    warehouse = Warehouse.create!(name: 'Aeroporto SP', 
                        code:'GRU', city: 'São Paulo',
                        area: 100_000,
                        address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
                        description: 'Galpão destinado para cargas internacionais')

    Supplier.create!(corporate_name: 'SIB-LTDA', 
                        brand_name: 'SIB', 
                        registration_number:'445464748',
                        full_address:'Torre de Indústrias, 45',
                        city:'Teresina', state: 'PI', 
                        email: 'contato@sib.com') 

    supplier = Supplier.create!(corporate_name:'ACME LTDA',
                        brand_name: 'ACME', 
                        registration_number:'4344721600',
                        full_address:'Av das Palmas, 100',
                        city:'Bauru', 
                        state: 'SP', 
                        email: 'contato@acme.com')
    
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('ABC12345')
    #act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: '20/12/2022'
    click_on 'Gravar'
    #assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Pedido ABC12345'
    expect(page).to have_content 'Galpão Destino: GRU - Aeroporto SP'
    expect(page).to have_content 'Fornecedor: ACME LTDA'
    expect(page).to have_content 'Usuário Responsável: Sergio - sergio@email.com'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).to have_content 'Situação do Pedido: Pendente'
    expect(page).not_to have_content 'Galpão Belo-Horizonte'
    expect(page).not_to have_content 'SIB-LTDA'
  end  

  it 'e não informa a data de entrega' do 
    #arrange
    user = User.create!(name: 'Sergio', email: 'sergio@email.com', password:'12345678')
    warehouse = Warehouse.create!(
      name: 'Aeroporto SP', 
      code: 'GRU', 
      address:'Endereço',
      cep:'25000-000', 
      city:'Rio', 
      area: 10000, 
      description: 'Alguma descriçao')
    supplier = Supplier.create!(
      corporate_name:'ACME LTDA',
      brand_name: 'ACME', 
      registration_number:'4344721600',
      full_address:'Av das Palmas, 100',
      city:'Bauru', 
      state: 'SP', 
      email: 'contato@acme.com'
    )

    #act
    login_as(user)
    visit root_path
    click_on 'Registrar Pedido'
    select 'GRU - Aeroporto SP', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data Prevista de Entrega', with: ''
    click_on 'Gravar'

    #assert
    expect(page).to have_content 'Não foi possível registrar o pedido.'
    expect(page).to have_content 'Data Prevista de Entrega não pode ficar em branco'
  end
end