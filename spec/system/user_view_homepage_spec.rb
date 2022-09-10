require 'rails_helper'

describe 'Usuario visita tela inicial' do 
  it  'e ve o nome do app' do 
    #arrange

    #act
    visit('/')


    #assert 
    expect(page).to have_content('Galpoes & Estoque')
  end
end 

