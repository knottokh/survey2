class Loghistory < ApplicationRecord
    belongs_to :school
    belongs_to :musictype
    belongs_to :user
    belongs_to :question
end
