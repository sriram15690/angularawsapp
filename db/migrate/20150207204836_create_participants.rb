class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :sankalpam_name
      t.string :address1
      t.string :address2
      t.string :city
      t.integer :pincode
      t.string :state
      t.string :gothram
      t.string :nakshatram
      t.string :rasi
      t.string :reference_name
      t.integer :roll_num
      t.integer :receipt_num
      t.date :receipt_date 
      t.date :renewal_date
      t.string :status
      t.string :title_name 
      t.string :telephone
      t.integer :sno
      t.integer :contact_id
      t.string :name
      t.string :email
      t.string :membership
      t.string :mobile_num
      t.string :name
      

      t.timestamps null: false
    end
  end
end
