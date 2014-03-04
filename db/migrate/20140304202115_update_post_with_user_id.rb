class UpdatePostWithUserId < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer
    add_timestamps :posts
  end
end
