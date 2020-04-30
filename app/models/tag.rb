class Tag < ApplicationRecord
  has_and_belongs_to_many :tickets
  validates :name, presence: true

  def self.count_all
    sql = <<-SQL
      SELECT COUNT(tags_tickets.tag_id) AS count, tags.name, tags.id AS id FROM tags_tickets RIGHT OUTER JOIN tags ON tags.id = tags_tickets.tag_id GROUP BY tags.name, tags.id ORDER BY tags.name;
    SQL

    result = ActiveRecord::Base.connection.execute(sql)

  end

  def self.option_tags
    all.map do |tag|
      [tag.name, tag.id]
    end
  end
end