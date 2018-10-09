class BlogController < ApplicationController
  layout 'blog'

  def index
    @posts = Post.where(is_published: true).last(5).reverse
    @tags = Tag.all
  end

  def search_tag
  end

  def single
    @post = Post.find_by(slug: params[:slug], is_published: true) or not_found
  end

  def search
  end

  def feed
    @posts = Post.where(is_published: true).last(5).reverse

    respond_to do |format|
      format.html { return redirect_to root_path }
      format.xml { render :layout => false }
      format.rss { render :layout => false, :template => 'blog/feed.xml.builder' }
    end
  end
end
