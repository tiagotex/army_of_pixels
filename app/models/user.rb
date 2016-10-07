class User < ApplicationRecord
  validates :username, presence: true
  validates :color_id, presence: true

  has_one :color
end
