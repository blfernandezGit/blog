class Task < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :body, presence: true,
    length: { minimum: 10, 
      message: "should have a minimum of 10 characters"}

  belongs_to :category
end
