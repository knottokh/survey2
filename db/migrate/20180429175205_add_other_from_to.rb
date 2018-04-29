class AddOtherFromTo < ActiveRecord::Migration[5.1]
  def change
    add_column :tanswers, :fromdep, :string
    add_column :tloghistories, :fromdep, :string
  end
end
