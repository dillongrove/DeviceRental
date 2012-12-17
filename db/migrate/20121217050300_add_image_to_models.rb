class AddImageToModels < ActiveRecord::Migration
  def change
    add_column :models, :image, :string
  end
end
