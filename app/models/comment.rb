class Comment < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  validates :body, presence: true

  def save_total_votes
    self.update_column(:total_votes, self.total_votes)
  end

end
