class UsersController < Clearance::UsersController

def new
  @user = User.new  #initialize an empty object for the form, so that we can fill in with details using the form.
  render template: "users/new"
end


def create
   @user = User.new(user_from_params)

   if @user.save
     sign_in @user
     redirect_back_or url_after_create
   else
     render template: "users/new"
   end
end

 def user_from_params
   params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
 end


end
