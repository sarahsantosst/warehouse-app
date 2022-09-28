require 'rails_helper'

RSpec.describe ProductModel, type: :model do
   describe '#valid?' do 
    it 'name is mandatory' do 

      #arrange
    supplier = Supplier.create(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'09845623419849', 
    full_address:'Av Nacoes Unidas, 1000' , city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br') 

    pm = ProductModel.new(name:'', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPT090', supplier: supplier)

    #act
    result = pm.valid?

    #assert
    expect(result).to eq false
    end

    it 'sku is madatory' do 
      supplier = Supplier.create(brand_name: 'Samsung', corporate_name: 'Samsung Eletronicos LTDA', registration_number:'09845623419849', 
        full_address:'Av Nacoes Unidas, 1000' , city: 'São Paulo', state: 'SP', email: 'sac@samsung.com.br') 
    
      pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: '', supplier: supplier)

      result = pm.valid?

      expect(result).to eq false
   end
 end
end
