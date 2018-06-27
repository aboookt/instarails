class SessionsController < ApplicationController
	def new

	end

	def create
		login = params[:session][:login]
		if login.include? "@"
			user = User.find_by_email(login)
		else
			user = User.find_by_username(login)
		end

		if user && user.authenticate(params[:session][:password])
			
			sign_in user
			redirect_to user
			#login
		else
			flash[:danger] = "Invalid username or password"
			render "new"
		end
	end

	def destroy
		sign_out if signed_in?
		redirect_to root_path
	end


end