require 'rails_helper'

describe  'Usuário se atentica' do 
  it  'com sucesso' do
    #arrange
    User.create!(name: 'Joao Silva', email:'joao@email.com', password:'password')

    #act
    visit root_path
    click_on 'Entrar'
    within('form') do
    fill_in 'E-mail', with: 'joao@email.com'
    fill_in 'Senha', with: 'password'
    click_on 'Entrar'
    end
    #assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
    within('nav') do
      expect(page).to have_content 'Joao Silva - joao@email.com'
    end
  end

  it 'e faz logout' do 
    #arrange
    User.create!(email:'joao@email.com', password:'password')
    #act
      visit root_path
      click_on 'Entrar'
      fill_in 'E-mail', with: 'joao@email.com'
      fill_in 'Senha', with: 'password'
      within('form') do
      click_on 'Entrar'
    end
      click_on 'Sair'
    #assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_button 'Sair'
    expect(page).not_to have_content 'joao@email.com'
  end
end