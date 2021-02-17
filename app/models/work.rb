class Work < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  has_many :comments

  with_options presence: true do
    validates :title
    validates :description
    validates :images
  end

  def self.search(keyword)
    if keyword != ""
      Work.where('title LIKE?', "%#{keyword}%").where('description LIKE?', "%#{keyword}%")
    else
      Work.all
    end
  end

end
