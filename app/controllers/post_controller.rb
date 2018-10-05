class PostController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def get
    if !params[:page].present? || param[s:page] == 0
      params[:page] = 1
    end

    respond_to do |f|
      f.json { render :json => {
	:page => params[:page],
	:post => Post.includes(:tags).paginate(:page => params[:page], per_page: 10 ).order('created_at DESC')
      }, :include => {:tags => { :only => :name }}}
      f.html { redirect_to root_path and return }
    end
  end

  def create
    p current_user
    if user_signed_in?
      post = Post.new(params.require(:post).permit(:title,:content,:tags_str, :is_published))
      post.is_published = true
      post.author_id = current_user.id
      post.slug = post.title.parameterize()

      # Make Unique Identifier for Post with same Title (Just In Case)
      if !Post.where(slug: post.slug).nil?
	post.slug += DateTime.now.strftime("%d%m%y")
      end

      if post.save
	respond_to do |f|
	  f.json { render :json => { message: "Remove Success!" } }
	  f.html { redirect_to dashboard_path and return }
	end
      end
    else
      respond_to do |f|
	f.json { render :json => { message: "Not Authorized" } }
	f.html { redirect_to login_path and return }
      end
    end
  end

  def edit
  end

  def destroy
    post = Post.find_by(id: params[:id])
    if !post.nil? && post.destroy
      respond_to do |f|
        f.html { redirect_to dashboard_path and return }
        f.json { render :json => { message: "Remove Success!" } }
      end
    end
  end
end
