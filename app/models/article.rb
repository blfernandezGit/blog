class Article < ApplicationRecord
    validates :name, presence: true,
        uniqueness: true
    validates :body, 
        length: { minimum: 10, 
            message: "should have a minimum of 10 characters"}
end

# format: { with: /\A[a-zA-Z]+\z/,
#     message: "only allows letters" },