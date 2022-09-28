require 'rails_helper'

describe 'Usuário edita um fornecedor' do 

  it 'a partir da página de detalhes' do 
    #arrange
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number:'4344721600', full_address:'Av das Palmas, 100', city:'Bauru', state: 'SP', email: 'contato@acme.com')
    
    #act
    visit root_path
    click_on 'Fornecedor'
    click_on 'ACME'
    click_on 'Editar'
    #assert
    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field('Razão Social', with: 'ACME LTDA')
    expect(page).to have_field('Nome Fantasia', with: 'ACME')
    expect(page).to have_field('Endereço', with: 'Av das Palmas, 100')
    expect(page).to have_field('CNPJ', with: '4344721600')
    expect(page).to have_field('Cidade', with:  'Bauru')
    expect(page).to have_field('Cidade', with:  'Bauru')
    expect(page).to have_field('Estado', with:  'SP')
    expect(page).to have_field('E-mail', with: 'contato@acme.com')
  end

  it 'com sucesso' do 
    #arrange
    warehouse = Warehouse.create!(name: 'Aeroporto SP', code:'GRU', city: 'Guarulhos', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

    #act
    visit root_path
    click_on 'Aeroporto SP'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão Internacional'
    fill_in 'Área', with:'200000'
    fill_in 'Endereço', with:'Avenida dos Galpões, 500'
    fill_in 'CEP', with:'16000-000'
    click_on 'Enviar'

    #assert
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Nome: Galpão Internacional'
    expect(page).to have_content 'Endereço: Avenida dos Galpões, 500'
    expect(page).to have_content 'Área: 200000 m2'
    expect(page).to have_content 'CEP: 16000-000'
  end


  it 'e mantém os campos obrigatórios' do 
    #arrange
    supplier = Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number:'4344721600', full_address:'Av das Palmas, 100', city:'Bauru', state: 'SP', email: 'contato@acme.com')
    #act
    visit root_path
    click_on 'Fornecedor'
    click_on 'ACME'
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with:''
    fill_in 'CNPJ', with:''
    fill_in 'Endereço', with:''
    fill_in 'Cidade', with:''
    fill_in 'Estado', with:''
    fill_in 'E-mail', with:''
    click_on 'Atualizar'

    #assert
    expect(page).to have_content 'Todos os campos são obrigatórios!'
 end 
end
  
 