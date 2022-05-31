class Article < ApplicationRecord
    # One to many relation
    belongs_to :user
    
    validates :title, presence: true, length: {'minimum': 10}
    validates :description, presence: true, length: {'minimum': 20}

    # Many to Many relation
    has_many :article_categories
    has_many :categories, through: :article_categories
end