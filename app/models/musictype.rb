class Musictype < ApplicationRecord
    has_many :answers  
    has_many :loghistories  
    has_many :questions  
end
