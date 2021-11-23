class Category < ApplicationRecord
    validates :name, presence: true,
        uniqueness: true,
        length: { minimum: 3, 
            message: "should have a minimum of 3 characters"}
end
