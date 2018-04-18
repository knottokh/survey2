class CreateFormmanages < ActiveRecord::Migration[5.1]
  def change
    create_table :formmanages do |t|
      t.boolean :islock
      t.integer :formtype
      
      t.timestamps
    end
    add_reference :formmanages, :school, foreign_key: true
    add_reference :formmanages, :user, foreign_key: true
  end
end
