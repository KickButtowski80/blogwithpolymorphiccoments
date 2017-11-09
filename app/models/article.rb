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
    has_many :comments, as: :commentable , :dependent => :destroy  , autosave: true 
    validates :title, presence: true, length:{ minimum: 5}
    # validates_presence_of :comments, on: :body
    before_validation :strip_whitespace
     
     
     
  def strip_whitespace      	
      #I added an unless self.name.blank? behind them, to avoid stripping NIL-values. 
      self.title = self.title.strip unless self.title.nil? 
      self.text  = self.text.gsub! /(\A\s*|\s*\z)/, ''  unless self.text.nil?
        #	I realize this is very old, but I wanted to point out two things..
        #   First, instead of self.name = self.name.strip unless self.name.nil?,
        #   I've come to prefer self.name.try(&:strip!). But if you are really
        #   looking to remove whitespace from the beginning and end,
        #   I find self.name.gsub! /(\A\s*|\s*\z)/, '' to be most reliable.
  end   
     
end
