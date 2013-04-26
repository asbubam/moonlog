class PostsController < ApplicationController
	before_filter :login_required

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params[:post].merge(:user_id => @current_user.id))

		unless @post.save
			flash[:notice] = "save post failed."
		end

		redirect_to root_path
	end
end
