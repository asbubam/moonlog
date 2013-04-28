class PostsController < ApplicationController
	before_filter :login_required
	before_filter :permission_check, :except => [:index, :new, :create]

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

	def edit
		@post = Post.find(params[:id])
	end

	def update 
		@post = Post.find(params[:id])
		
		if @post.update_attributes(params[:post])
			redirect_to  root_path, notice:'Post was successfully updated.'
		else
			render :action => "edit"
		end
	end

	def destroy
		unless @post.destroy
			flash[:notice] = "destroy post failed."
		end
		
		redirect_to root_path
	end

protected
	def permission_check
		@post = Post.find(params[:id])
		unless @post.user.id == @current_user.id
			raise PermissionException
		end
	end
end
