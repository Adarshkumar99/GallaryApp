class AlbumsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @albums = current_user.albums 
    @q = @albums.ransack(params[:q])
    @albums = @q.result.includes(:tags)
  
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    #@album = Album.new
    @album = current_user.albums.build
  end

  def create
   # @album = current_user.albums.new(album_params)
    @album = current_user.albums.build(album_params)

    if @album.save
      redirect_to @album, notice: "Album created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)      
      redirect_to @album,  notice: 'Album was successfully updated.' 
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to root_path, notice: 'Album was successfully deleted.',  status: :see_other
  end
  

  def purge
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.purge
    redirect_to albums_url, notice: "image deleted successfully"
  end
  
  

  def correct_user
    @album = current_user.albums.find_by(id: params[:id])
    redirect_to new_album_path, alert: "Not Authorized" if @album.nil?
  end


 


  private
    def album_params
      params.require(:album).permit(:title, :description, :all_tags, :published, :cover_image, :user_id, :images => [])
    end
end
