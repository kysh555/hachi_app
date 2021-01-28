class WorksController < ApplicationController

  def index
  end

  def new
    @work = Work.new
  end
  
end
