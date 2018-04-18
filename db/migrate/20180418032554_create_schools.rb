class CreateSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :schools do |t|
      t.string :education_area
      t.string :ministry_code
      t.string :school_name
      t.string :municipal_area
      t.string :district
      t.string :province
      t.string :postcode
      t.integer :zone
      t.integer :students_count
      
      t.timestamps
    end
  end
end
