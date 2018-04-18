class CreateMusictypes < ActiveRecord::Migration[5.1]
  def change
    create_table :musictypes do |t|
      t.string :title
      t.integer :formtype
      t.integer :orderno
      
      t.timestamps
    end
  end
end
