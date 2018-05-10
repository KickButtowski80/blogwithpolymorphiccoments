# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commenter        :string
#  body             :text
#  commentable_type :string
#  commentable_id   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true, optional: true 
    #validates_associated :commentable
    validates :body, presence: true, length: {minimum: 5, maximimum: 1000 }
    after_create_commit { CommentBroadcastJob.perform_later(self) }
end
