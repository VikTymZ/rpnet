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
end
