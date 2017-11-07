# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :integer
#

class Article < ApplicationRecord
    belongs_to :admin , optional: true
    has_many :comments, as: :commentable , :dependent => :destroy   
    #validates :admin, presence: true
    validates :title, presence: true, length:{ minimum: 5}
end
