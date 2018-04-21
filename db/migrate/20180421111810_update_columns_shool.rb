class UpdateColumnsShool < ActiveRecord::Migration[5.1]
  def change
      add_column :schools, :percent_all, :float
      add_column :schools, :percent_1, :float
      add_column :schools, :percent_2, :float
      add_column :schools, :percent_3, :float
      add_column :schools, :percent_4, :float
  end
end
