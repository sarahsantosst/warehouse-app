require 'rails_helper'

describe 'Usuario visita tela inicial' do 
  it  'e vê o nome do app' do 
    #arrange

    #act
    visit(root_path)


    #assert 
    expect(page).to have_content('Galpões & Estoque')
  end

    it 'e vê galpoes cadastrados' do
    
    Warehouse.create(name:'Rio' , code: 'SDU', city: 'Rio de Janeiro', area: 60_000)
    Warehouse.create(name:'Maceio' , code: 'MCZ', city:'Maceio', area: 50_0000)

    #act
    visit(root_path)

    #assert
    expect(page).not_to have_content('não existem galpões cadastrados')
    expect(page).to have_content( 'Rio')
    expect(page).to have_content( 'Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')

    expect(page).to have_content( 'Maceio')
    expect(page).to have_content( 'Código: MCZ')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m2')
    end 

    it 'e não existem galpões cadastrados' do 

      #arrange

      #act
      visit (root_path)
      #assert

      expect(page).to have_content('não existem galpões cadastrados')
    end 


  end

