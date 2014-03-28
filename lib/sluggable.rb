module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def to_param
    self.slug
  end

  def generate_slug!
    str = slugify self.send(self.class.slug_column.to_sym)
    count = 2
    obj = self.class.where(slug: str).first
    while obj && obj != self
      str = str + "-" + count.to_s
      obj = self.class.where(slug: str).first
      count += 1
    end
    self.slug = str
  end

  def slugify name
    str = name.strip

    str.gsub! /['`]/,""
    str.gsub! /\s*@\s*/, " at "
    str.gsub! /\s*&\s*/, " and "
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, '-'
    str.gsub! /\A[-\.]+|[-\.]+\z/,""

    str.downcase
  end

  module ClassMethods
    def sluggable_column name
      self.slug_column = name
    end
  end

end
