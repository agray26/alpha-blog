class Article < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { minimum: 1, maximum: 69}
    validates :description, presence: true, length: { minimum: 1, maximum: 200}
end