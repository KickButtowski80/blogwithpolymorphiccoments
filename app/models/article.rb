class Article < ApplicationRecord
    has_many :comments, as: :commentable , :dependent => :destroy
    
    validates :title, presence: true, length:{ minimum: 5}
end
