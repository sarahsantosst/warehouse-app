require 'rails_helper'

describe  'Usuário vê detalhes de um galpão' do 
  it 'e vê informações adicionais' do

    #arrange 
    w = Warehouse.new(name: 'Aeroporto SP', code:'GRU', city: 'São Paulo', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')
    
    w.save()
    #act 
    visit(root_path)
    click_on('Aeroporto SP')


    #assert
    expect(page).to have_content('Galpão GRU')
    expect(page).to have_content('Nome: Aeroporto SP')
    expect(page).to have_content('Cidade: São Paulo')
    expect(page).to have_content('Área: 100000 m2')
    expect(page).to have_content('Endereço: Avenida do Aeroporto, 1000 CEP: 15000-000')
    expect(page).to have_content('Galpão destinado para cargas internacionais') 
  end
  it 'e volta para tela inicial' do 
  #arrange 
  w = Warehouse.create(name: 'Aeroporto SP', code:'GRU', city: 'São Paulo', area: 100_000, address: 'Avenida do Aeroporto, 1000', cep: '15000-000', description: 'Galpão destinado para cargas internacionais')

  #act
visit (root_path)
click_on 'Aeroporto SP'
click_on 'Voltar'
  #assert

expect(current_path).to eq('/')
  end
end