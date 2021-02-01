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
  
  private
  def work_params
    params.require(:work).permit(:title, :description, images: []).merge(user_id: current_user.id)
  end
end
