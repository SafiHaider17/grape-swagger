class AddSizeAndColorToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :size, :string, array: true, default: []
    add_column :products, :color, :string, array: true, default: []
  end
end
