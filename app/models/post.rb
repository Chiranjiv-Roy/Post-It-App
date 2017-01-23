class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable
  has_attached_file :pic, styles: { medium: "600x500>", thumb: "100x100>" }, default_url: "/assets/images/missing.png"
  validates_attachment_content_type :pic, content_type: /\Aimage\/.*\z/

  validates :title, presence: true, length: {minimum: 5}
  validates :url, presence: true, uniqueness: true
  validates :description, presence: true

  def total_votes
    self.votes.where(vote: true).size - self.votes.where(vote: false).size
  end
end