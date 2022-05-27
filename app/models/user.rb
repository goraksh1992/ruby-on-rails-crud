class User < ApplicationRecord
    # Before save it convert email to lowercase
    before_save { self.email = email.downcase }

    # Article reference and if user deleted that user all article will be deleted
    has_many :articles, dependent: :destroy

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :username, presence: true, 
                    uniqueness: {case_sensitive: false},
                    length: { minimum: 3, maximum: 25}
    validates :email, presence: true, 
                    uniqueness: {case_sensitive: false},
                    length: {maximum: 105},
                    format: {with: VALID_EMAIL_REGEX}
    
    has_secure_password

    has_one_attached :profile_image
end