class AddColumnsToAllTable < ActiveRecord::Migration[5.1]
  def change
      #add_column :users, :role, :integer
      #add_reference :questions, :musicin, foreign_key: true
      ###users
      add_column :users, :username, :string , default: ""
      add_column :users, :prefix, :string
      add_column :users, :name, :string
      add_column :users, :surname, :string
      add_column :users, :cardnumber, :string
      add_column :users, :position, :string
      add_column :users, :phone, :string
      add_reference :users, :school, foreign_key: true
      ###answers
      add_reference :answers, :school, foreign_key: true
      add_reference :answers, :question, foreign_key: true
      add_reference :answers, :musictype, foreign_key: true
      ###tanswers
      add_reference :tanswers, :school, foreign_key: true
      ###loghistories
      add_reference :loghistories, :school, foreign_key: true
      add_reference :loghistories, :question, foreign_key: true
      add_reference :loghistories, :musictype, foreign_key: true
      add_reference :loghistories, :user, foreign_key: true
      ###tloghistories
      add_reference :tloghistories, :school, foreign_key: true
      add_reference :tloghistories, :user, foreign_key: true
      ###questions
      add_reference :questions, :musictype, foreign_key: true
  end
end
