class CreateTdegrees < ActiveRecord::Migration[5.1]
  def change
    create_table :tdegrees do |t|
      t.string :title

      t.timestamps
    end
  end
end
