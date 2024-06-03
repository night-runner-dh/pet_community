class Tag < ApplicationRecord
  belongs_to :post

  def self.unique_tags
    Tag.select('DISTINCT name')
  end


end
