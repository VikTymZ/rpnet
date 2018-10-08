class DashboardController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'

  def index
  end

  def new
  end

  def edit
    @post = Post.find_by(:id => params[:id]);
  end

end
