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
    if user_signed_in?
      post = Post.new(params.require(:post).permit(:title,:content,:tags_str, :is_published))
      post.user = current_user
      post.slug = post.title.parameterize()

      # Make Unique Identifier for Post with same Title (Just In Case)
      if !Post.where(slug: post.slug).empty?
	post.slug += DateTime.now.strftime("%d%m%y")
      end

      if post.save
	respond_to do |f|
	  f.json { render :json => { message: "Remove Success!" } }
	  f.html { redirect_to dashboard_path and return }
	end
      else
        p post.errors
      end
    else
      respond_to do |f|
	f.json { render :json => { message: "Not Authorized" } }
	f.html { redirect_to login_path and return }
      end
    end
  end

  def edit
    if user_signed_in?
      post = Post.find_by(:id => params[:id])
      if post.update(params.require(:post).permit(:title, :content, :tags_str, :is_published))
	respond_to do |f|
	  f.json { render :json => { message: "Post Successfuly Updated!" } }
	  f.html { redirect_to dashboard_path and return }
	end
      else
	respond_to do |f|
	  f.json { render :json => { message: "Failed to Update Post!", errors: post.errors } }
	  f.html { redirect_to dashboard_path and return }
	end
      end
    end
  end

  def remove
    if user_signed_in?
      post = Post.find_by(id: params[:id])
      if !post.nil? && post.destroy
	respond_to do |f|
	  f.html { redirect_to dashboard_path and return }
	  f.json { render :json => { message: "Remove Success!" } }
	end
      end
    end
  end
end
