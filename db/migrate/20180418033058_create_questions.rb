class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :choice
      t.string :qtype
      
      t.timestamps
    end
  end
end