require 'rails_helper'

describe 'Usuário vê fornecedores' do 
  it 'a partir do menu' do 
    #arrange

    #act
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    #assert
    expect(current_path).to eq suppliers_path
  end

  it 'com sucesso' do 
    #arrange
    Supplier.create!(corporate_name: 'ACME-LTDA', brand_name: 'ACME', registration_number:'4344721600', full_address:'Av das Palmas, 100', city:'Bauru', state: 'SP', email: 'contato@acme.com')

    Supplier.create!(corporate_name: 'SIB-LTDA', brand_name: 'SIB', registration_number:'445464748', full_address:'Torre de Indústrias, 45', city:'Teresina', state: 'PI', email: 'contato@sib.com')

    #act
    visit root_path
    click_on 'Fornecedores'

    #assert
    expect(page).to have_content('Fornecedores')
    expect(page).to have_content('ACME')
    expect(page).to have_content('Bauru SP')
    expect(page).to have_content('SIB')
    expect(page).to have_content('Teresina PI')
  end


  it 'e não existe fornecedores cadastrados' do 
    #arrange

    #act
    visit root_path
    click_on 'Fornecedores'

    #assert
    expect(page).to have_content 'Não existem fornecedores cadastrados.'

  end
end


