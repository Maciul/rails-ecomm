class RenameMisspelledColumnInOrderProducts < ActiveRecord::Migration[8.0]
  def change
    rename_column :order_products, :quanity, :quantity
  end
end
