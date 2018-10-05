class Post < ApplicationRecord
  has_many :post_tags
  has_many :tags, through: :post_tags

  def tags_str=(list)
    self.tags = list.split(",").map do |l|
      Tag.where(name: l.strip).first_or_create
    end
  end

  def tags_str
    self.tags.map(&:name).join(", ")
  end
end
