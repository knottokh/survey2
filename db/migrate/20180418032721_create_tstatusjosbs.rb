class CreateTstatusjosbs < ActiveRecord::Migration[5.1]
  def change
    create_table :tstatusjosbs do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
