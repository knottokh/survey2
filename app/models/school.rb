class School < ApplicationRecord

  
  has_many :users  
  has_many :answers 
  has_many :tanswers  
  has_many :loghistories 
  has_many :tloghistories 
  has_many :formmanages 
end
