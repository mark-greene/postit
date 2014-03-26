class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  before_save :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = slugify self.name
    obj = Category.find_by slug: the_slug
    count = 2
    while obj && obj != self
      the_slug = append_suffix the_slug, count
      obj = Category.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug
  end

  def append_suffix str, count
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return str + '-' + count.to_s
    end
  end

  def slugify str
    the_slug = str.strip
    the_slug.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    the_slug.gsub! /-+/, '-'
    the_slug.downcase!
  end

end
