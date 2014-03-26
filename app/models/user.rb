class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates  :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 3}

  before_save :generate_slug!

  def admin?
    self.role == 'admin'
  end

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = slugify self.username
    obj = User.find_by slug: the_slug
    count = 2
    while obj && obj != self
      the_slug = append_suffix the_slug, count
      obj = User.find_by slug: the_slug
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
    the_slug.downcase
  end

end
