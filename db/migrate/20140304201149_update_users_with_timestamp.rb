class UpdateUsersWithTimestamp < ActiveRecord::Migration
  def change
    add_timestamps :users
  end
end
