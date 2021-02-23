class Tag < ApplicationRecord
  has_many :work_tags
  has_many :works, through: :work_tags
end
