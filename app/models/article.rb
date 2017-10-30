class Article < ApplicationRecord
    belongs_to :admin , optional: true
    has_many :comments, as: :commentable , :dependent => :destroy   
    #validates :admin, presence: true
    validates :title, presence: true, length:{ minimum: 5}
end
