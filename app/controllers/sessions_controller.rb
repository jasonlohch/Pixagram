class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email])
  	if user && user.authenticate(params[:session][:password])
  	  sign_in user
      flash[:success] = 'You are now signed in'
  	  redirect_to root_path
  	else
  	  flash.now[:warning] = 'Please log in again'
      render 'new'
  	end
  end

  def destroy
  	sign_out if signed_in?
    flash[:success] = 'Signed out success'
  	redirect_to root_path
  end

  def create_from_omniauth
      auth_hash = request.env["omniauth.auth"]
      authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

      # if: previously already logged in with OAuth
      if authentication.user
        user = authentication.user
        authentication.update_token(auth_hash)
        @next = user_url(user)
        @notice = "Signed in!"
      # else: user logs in with OAuth for the first time
      else
        user = User.create_with_auth_and_hash(authentication, auth_hash)
        # you are expected to have a path that leads to a page for editing user details
        @next = edit_user_path(user)
        @notice = "User created. Please confirm or edit details"
      end

      sign_in(user)
      redirect_to @next, :notice => @notice
  end

end
