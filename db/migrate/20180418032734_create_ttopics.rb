class CreateTtopics < ActiveRecord::Migration[5.1]
  def change
    create_table :ttopics do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
