class SessionsController < ApplicationController
  def new
    # render login form in sessions/new.html.erb
  end

  def create
    # authenticate the user
    # 1. try to find the user by their unique identifier
    @user = User.find_by({"email"=>params["email"]})
    # 2. if the user exists -> check if they know their password
    if @user != nil
    # 3. if they know their password -> login is successful
      if BCrypt::Password.new(@user["password"]) == params["password"]
        cookies["monster"] = "me like cookies"
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome."
        redirect_to "/companies"
      else
        flash["notice"] = "Wrong password!"
        redirect_to "/login"
      end
    else
    flash["notice"] = "Username does not exist!"
    redirect_to "/login"
    end
        # 4. if the user doesn't exist or they don't know their password -> login fails
    
  end

  def destroy
    # logout the user
    flash["notice"] = "Goodbye."
    cookies["monster"] = nil
    session["user_id"] = nil
    cookies["user_id"] = nil
    redirect_to "/login"
  end
end
