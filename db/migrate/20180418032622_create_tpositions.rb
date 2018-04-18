class CreateTpositions < ActiveRecord::Migration[5.1]
  def change
    create_table :tpositions do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
