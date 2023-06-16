class BookmarksController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.save(bookmark_params)
      redirect_to list_path(@list)
      flash.now[:notice] = 'Bookmark was successfully created.'
    else
      flash.now[:alert] = @bookmark.errors.full_messages.join(', ')
      render :new
    end
  end

  # def edit
  #   @list = List.find(params[:list_id])
  #   @bookmark = Bookmark.find(params[:id])
  # end

  # def update
  #   @list = List.find(params[:list_id])
  #   @bookmark = Bookmark.find(params[:id])
  #   if @bookmark.update(bookmark_params)
  #     redirect_to list_path(@list), notice: 'Bookmark was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to list_path(@bookmark.list)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
