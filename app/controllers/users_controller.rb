class UsersController < ApplicationController
	before_action :logged_in_user,  only: [:index, :edit, :update]
	before_action :correct_user, 	only: [:edit, :update]
	before_action :admin_user, 		only: :destroy

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

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless @user == current_user
		end

		def logged_in_user
			unless logged_in?
				redirect_to login_url
			end
		end

		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
