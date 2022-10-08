class AddOrderToStockProduct < ActiveRecord::Migration[7.0]
  def change
    add_reference :stock_products, :order, null: false, foreign_key: true
  end
end
