class MediaController < ApplicationController
  before_action :authenticate_user!

  def upload
    media = Media.new();

    if params[:file].nil?
       render :json => { message: "Upload Failed, Nothing Attached!" }
    end

    media.file.attach(params[:file])
    media.url = url_for(media.file)

    if media.save
      render :json => { message: "Success!", media_url: media.url, is_success: true }
    else
      render :json => { message: "Upload Failed!", errors: media.errors, is_success: false }
    end
  end

  def fetch
    render :json => Media.paginate(:page => params[:page], per_page: 10 ).order('created_at DESC')
  end
end
