class WorksController < ApplicationController

  def index
    @works = Work.all
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
    @work = Work.find(params[:id])
    @work.destroy
  end
  
  private
  def work_params
    params.require(:work).permit(:title, :description, images: []).merge(user_id: current_user.id)
  end
end
