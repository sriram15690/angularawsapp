class CreatePrasadams < ActiveRecord::Migration
  def change
    create_table :prasadams do |t|
      t.integer :eventinstance_id
      t.string :status 
      t.timestamps null: false
    end
  end
end
