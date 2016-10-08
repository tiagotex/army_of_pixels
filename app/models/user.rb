class User < ApplicationRecord
  validates :username, presence: true
  validates :color_id, presence: true

  belongs_to :color, counter_cache: true
end
