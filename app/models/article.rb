class Article < ApplicationRecord
    validates :name, presence: true,
        uniqueness: true
    validates :body,
        presence: true,
        length: { minimum: 10, 
            message: "should have a minimum of 10 characters"}

    has_many :comments
end
# format: { with: /\A[a-zA-Z]+\z/,
#     message: "only allows letters" },