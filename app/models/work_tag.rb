class WorkTag
  include ActiveModel::Model
  attr_accessor :title, :description, :images, :tag_name, :user_id, :work_id, :tag_id

  with_options presence: true do
    validates :title
    validates :description
    validates :images
  end

  delegate :persisted?, to: :work

  def initialize(attributes = nil, work: Work.new, tag: Tag.new)
    @work = work
    @tag = tag
    attributes ||= default_attributes
    super(attributes)
  end
  
  def save
      @work = Work.create(title: title, description: description, images: images, user_id: user_id)
      @tag = Tag.where(tag_name: tag_name).first_or_initialize
      @tag.save
      WorkTagRelation.create(work: work, tag: tag)
  end
  
  def to_model
    work
  end

  private

  attr_reader :work, :tag
    
  def default_attributes
    {
      title: work.title,
      description: work.description,
      images: work.images,
      tag_name: tag.tag_name,
      user_id: work.user_id
    }
  end

end