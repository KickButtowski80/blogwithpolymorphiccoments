# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string
#  description :string
#

class Project < ApplicationRecord
    # belongs_to :admin , optional: true
end
