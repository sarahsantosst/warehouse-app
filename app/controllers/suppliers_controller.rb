class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def new
    @supplier = Supplier.new
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save()
      redirect_to @supplier, notice: 'Fornecedor cadastrado com sucesso.'
    else
      flash.now[:alert] = 'Fornecedor não cadastrado.'
      render 'new'
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update(supplier_params)
      redirect_to @supplier, notice: 'Fornecedor atualizado com sucesso.'
    else
      flash.now[:notice] = "Todos os campos são obrigatórios!"
      render 'edit'
    end
  end

  def supplier_params
    supplier_params = params
      .require(:supplier)
      .permit(:corporate_name, :brand_name, :registration_number, :city, :state, :full_address, :cep, :email)
  end
end 