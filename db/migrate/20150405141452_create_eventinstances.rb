class CreateEventinstances < ActiveRecord::Migration
  def change
    create_table :eventinstances do |t|
      t.integer :event_id
      t.string :eventtype
      t.datetime :eventdate
      t.timestamps null: false
    end
  end
end
