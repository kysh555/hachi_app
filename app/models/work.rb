class Work < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_many :work_tag_relations, dependent: :destroy
  has_many :tags, through: :work_tag_relations

end
