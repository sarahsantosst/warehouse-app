require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do 
    #arrange
    w = Warehouse.create!(name: 'Cuiaba', code: 'CMB', area: 10000, cep: '56000-000', city: 'Cuiabá', description: 'Galpão no centro do país', address: 'Av dos Jacarés, 1000')
    #act
    visit root_path
    click_on 'Cuiaba'
    click_on 'Remover'

    #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Cuiaba'
    expect(page).not_to have_content 'CWB'
  end

 it 'e não apaga outros galpões' do
   
  first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWB', area: 10000, cep:'56000-000', city:'Cuiabá', description:'Galpão no centro do país',
  address:'Av dos Jacarés, 1000')
  
  second_warehouse = Warehouse.create!(name: 'Belo-Horizonte', code: 'BHZ', area: 20000, cep: '46000-000', city: 'Belo-Horizonte', description: 'Galpão para cargas mineiras', address: 'Av Tiradentes, 20')
 #act
  visit root_path
  click_on 'Cuiaba'
  click_on'Remover'

  #assert
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Belo-Horizonte'
    expect(page).not_to have_content 'Cuiaba'
  end
end