class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :mobile_num
      t.string :email
      t.string :status
      t.string :city
      t.string :membership

      t.timestamps
    end
  end
end
