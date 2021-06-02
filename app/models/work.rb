class Work < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :work_tag_relations, dependent: :destroy
  has_many :tags, through: :work_tag_relations


  def self.search(keyword)
    if keyword != ""
      Work.where('title LIKE ? OR description LIKE ?', "%#{keyword}%", "%#{keyword}%")
    else
      Work.all
    end
  end

end
