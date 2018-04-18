class CreateTanswers < ActiveRecord::Migration[5.1]
  def change
    create_table :tanswers do |t|
      t.string :prefix
      t.string :name
      t.string :surname
      t.string :status
      t.string :position
      t.string :degree
      t.string :branch
      t.string :university
      t.string :topic
      t.string :remark
      
      t.timestamps
    end
  end
end
