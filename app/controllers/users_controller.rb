class UsersController < ApplicationController
	def index
		@user = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			log_in @user
			redirect_to @user
		else
			render 'new'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy

		redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end
end
