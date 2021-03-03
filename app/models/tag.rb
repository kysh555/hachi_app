class Tag < ApplicationRecord
  has_many :work_tag_relations, dependent: :destroy
  has_many :works, through: :work_tag_relations

  validates :tag_name, uniqueness: true
end
