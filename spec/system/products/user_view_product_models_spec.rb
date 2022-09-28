require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 
  it 'a partir do menu' do 
    #arrange

    #act
    visit root_path
     within('nav') do
      click_on 'Modelos de Produtos'
     end
    #assert
    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do 
    #arrange
    supplier = Supplier.create(brand_name:'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'0984562341984', full_address:'Av Nacoes Unidas, 1000' , city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br')  

    ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, depth:10, sku:'TV 32-SAMSU-XPT090', supplier: supplier)
    ProductModel.create!(name:'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZ77', supplier: supplier)
    #act

    visit root_path
    within('nav') do
     click_on 'Modelos de Produtos'
    end
    #assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV 32-SAMSU-XPT090'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ77'
    expect(page).to have_content 'Samsung'
  end
  it  'e não existem produtos cadastrados' do
   #arrange
   #act
   visit root_path
   click_on 'Modelos de Produtos'
   #assert
    expect(page).to have_content 'Nenhum modelo de produto cadastrado.'
  end
end