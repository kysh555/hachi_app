class UsersController < ApplicationController

  def show
    @nickname = current_user.nickname
    @works = current_user.works
  end

end
