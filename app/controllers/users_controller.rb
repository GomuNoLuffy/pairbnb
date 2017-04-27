class UsersController < Clearance::UsersController

  def index
  end 

  def new
    @user = User.new  #initialize an empty object for the form, so that we can fill in with details using the form.
    render template: "users/new"
  end


def create
   @user = User.new(user_from_params)
   
  respond_to do |format|
     if @user.save
       sign_in @user
       flash[:success] = "Welcome to Pairbnb!"
       redirect_back_or url_after_create
     else
        # @message = @user.errors.full_messages.first
          format.html #{ redirect_to new_user_path}
          format.js { @user }
          # @user.errors.any?
          #   @user.errors.each do |key, value|
          #   end 
      end
    end
end

 def user_from_params
   params.require(:user).permit(:username, :first_name, :last_name, :email, :password)
 end

  def show
    @user = User.find(params[:id])
  end

end
