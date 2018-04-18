class CreateTuniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :tuniversities do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
