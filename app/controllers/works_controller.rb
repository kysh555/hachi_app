class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @works = Work.all.order("created_at DESC")
  end

  def new
    @work_tag = WorkTag.new
  end

  def create
    @work_tag = WorkTag.new(work_params)
    if @work_tag.valid?
      @work_tag.save
    else
      render :new
    end
  end

  def show
    @work = Work.find(params[:id])
    @nickname = @work.user.nickname
    @comment = Comment.new
    @comments = @work.comments.includes(:user)
  end

  def edit
    @work_tag = WorkTag.new(work: @work)
  end

  def update
    if @work_tag = WorkTag.new.update(work_params)
      render :edit
    else
      redirect_to 
    end
  end

  def destroy
    work = Work.find(params[:id])
    work.destroy
  end

  def search
    @works = Work.search(params[:keyword])
  end

  private
  def work_params
    params.require(:work).permit(:title, :description, :tag_name, images: []).merge(user_id: current_user.id, work_id: params[:id])
  end

  def find_work
    @work = Work.find(params[:id])
    @tag = @work.tags
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
