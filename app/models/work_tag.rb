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
    work = Work.create(title: title, description: description, images: images, user_id: user_id)
    tag = Tag.find_or_create_by(tag_name: tag_name)
    WorkTagRelation.create(work: work, tag: tag)
  end

  def update(params)
    @work = Work.find(params[:work_id])
    work = @work.update(title: params[:title], description: params[:description], images: params[:images])
    @tag = @work.tags
    tag = @tag.find_or_create_by(tag_name: params[:tag_name])

    wtr = WorkTagRelation.where(work_id: work_id)
    wtr.update(work: work, tag: tag)
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