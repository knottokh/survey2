class Question < ApplicationRecord
  belongs_to :musictype
  has_many :answers 
  has_many :loghistories 
end
