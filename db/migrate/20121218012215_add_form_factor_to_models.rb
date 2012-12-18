class AddFormFactorToModels < ActiveRecord::Migration
  def change
    add_column :models, :form_factor, :string
  end
end
