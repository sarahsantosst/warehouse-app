require 'rails_helper'

describe 'Usuário vê detalhes do fornecedor' do 
  it  'a partir da tela inicial' do 
    #arrange
    Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number:'4344721600', full_address:'Av das Palmas, 100', city:'Bauru', state: 'SP', email: 'contato@acme.com')

    #act
    visit root_path
    click_on  'Fornecedores'
    click_on 'ACME'
    #assert
    expect(page).to have_content( 'ACME LTDA')
    expect(page).to have_content('Documento: 4344721600 ')
    expect(page).to have_content('Endereço: Av das Palmas, 100, Bauru - SP')
    expect(page).to have_content('E-mail: contato@acme.com')
  end  

  it  'e volta para tela inicial' do 
    #arrange
    Supplier.create!(corporate_name:'ACME LTDA', brand_name: 'ACME', registration_number:'4344721600', full_address:'Av das Palmas, 100', city:'Bauru', state: 'SP', email: 'contato@acme.com')

    #act
    visit root_path
    click_on 'Fornecedores'
    click_on 'ACME'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end