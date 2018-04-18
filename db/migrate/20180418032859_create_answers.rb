class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :answer
      t.string :answer2
      t.string :othertitle
      
      t.timestamps
    end
  end
end
