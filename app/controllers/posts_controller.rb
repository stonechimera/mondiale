class PostsController < ApplicationController
	before_action :set_post, only: [:edit, :update, :destroy, :vote]

	def new
		@chapter = Chapter.find(params[:chapter_id])
		@post = @chapter.posts.new()
   	@post_attachment = @post.post_attachments.build
	end

	def create
		@chapter = Chapter.find(params[:chapter_id])
		@post = @chapter.posts.new(post_params)
		if @post.save
      save_images
			flash[:success] = "Your post has been created successfully"
			redirect_to trip_chapter_path(@post.trip, @post.chapter)
		else
			render :new
		end
	end

	def edit
		@chapter = Chapter.find(params[:chapter_id])
    @post = Post.find(params[:id])
    @post_attachment = @post.post_attachments.build
	end

	def vote

    if params[:unvote]
      @post.unliked_by(current_user)
    else
      @post.liked_by(current_user)
    end
    respond_to do |format|
      format.html {redirect_to @trip}
      format.js
    end

  end

	def update
		if @post.update(post_params)
			save_images
			flash[:success] = "Your post has been updated successfully"
			redirect_to trip_chapter_path(@post.trip, @post.chapter)
		else
			render :edit
		end
	end

	def destroy
		if @post.destroy
			flash[:success] = "Your post has been deleted successfully"
			redirect_to trip_chapter_path(@post.trip, @post.chapter)
		end
	end

private

	def save_images
		if params[:post_attachments]
			params[:post_attachments]['postimage'].each do |a|
	   	  @post_attachment = @post.post_attachments.create!(:postimage => a, :post_id => @post.id)
    	end
  	end
	end

	def set_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content, :date, :location, :post_attachments)
	end

end
