class AddAdminToArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :admin, foreign_key: true
  end
end
