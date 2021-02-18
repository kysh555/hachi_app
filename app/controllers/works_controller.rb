class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]
  before_action :move_to_index, except: [:index, :show]

  def index
    @works = Work.all.order("created_at DESC")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  def show
    @work = Work.find(params[:id])
    @nickname = @work.user.nickname
    @comment = Comment.new
    @comments = @work.comments.includes(:user)
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    @work.update(work_params)
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
    params.require(:work).permit(:title, :description, images: []).merge(user_id: current_user.id)
  end

  def find_work
    @work = Work.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
