class CreateModelFeatures < ActiveRecord::Migration
  def change
    create_table :model_features do |t|
      t.integer :id
      t.integer :feature_id
      t.integer :model_id

      t.timestamps
    end
  end
end
