class WorkTag
  include ActiveModel::Model
  attr_accessor :title, :description, :images, :tag_name, :user_id

  with_options presence: true do
    validates :title
    validates :description
    validates :images
    validates :tag_name
  end

  def save
    work = Work.create(title: title, description: description, images: images, user_id: user_id)
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    tag.save

    WorkTagRelation.create(work_id: work.id, tag_id: tag.id)
  end
end