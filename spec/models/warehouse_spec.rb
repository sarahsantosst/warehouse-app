require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
    it  'false when name is empty' do 
       warehouse = Warehouse.new(name: '', code: 'RIO', address:'Endereço', cep:'25000-000', city:'Rio', area: 10000, description: 'Alguma descriçao' )
      
      result = warehouse.valid?
     
      expect(result).to eq false
  end

  it  'false when code is empty' do 
  
        warehouse = Warehouse.new(name: 'Rio', code: '', address:'Endereço', cep:'25000-000', city:'Rio', area: 10000, description: 'Alguma descriçao' )
        result = warehouse.valid?

        expect(result).to eq false
  end

  it  'false when address is empty' do 
      warehouse = Warehouse.new(name: 'Rio', code: 'RIO', address:'', cep:'25000-000', city:'Rio', area: 10000, description: 'Alguma descriçao' )
      result = warehouse.valid?
      expect(result).to eq false
      end
  end


   it  'false when code is already in use' do
    #arrenge
    first_warehouse = Warehouse.create(name: 'Nome', code:'RIO',address:'Endereço', 
    cep:'25000-000', city:'Rio', area: 10000, description: 'Alguma descriçao' )

    second_warehouse = Warehouse.new(name: 'Niteroi', code: 'RIO', address:'Avenida', cep:'35000-000', city:'Niteroi', area: 10000, description: 'Outra descriçao' )
    #act
    result = second_warehouse.valid?

    #assert
    expect(result).to eq false
    end
   end
end

describe '#full_description' do 
   it  'exibe o nome fantyasia e a razão social' do
    #arrange
    w = Warehouse.new(name:'Galpão Cuiába', code: 'CBA')
    #act
    result = w.full_description
    #assert
    expect(result).to eq('CBA - Galpão Cuiába')
   end
  end


