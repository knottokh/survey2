class Answer < ApplicationRecord
    belongs_to :school
    belongs_to :question
    belongs_to :musictype
end
