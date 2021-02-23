class Work < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :comments
  has_many :work_tags
  has_many :tags, through: :work_tags

  with_options presence: true do
    validates :title
    validates :description
    validates :images
  end

end
