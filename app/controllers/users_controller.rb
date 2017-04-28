class UsersController < Clearance::UsersController

  def index
  end 

  def new
    @user = User.new  #initialize an empty object for the form, so that we can fill in with details using the form.
    render template: "users/new"
  end


def create
   @user = User.new(user_from_params)
   

     if @user.save
       sign_in @user
       flash[:success] = "Welcome to Pairbnb!"
       redirect_back_or url_after_create
     else
      respond_to do |format|


          format.html #{ redirect_to new_user_path}
          format.js { @user }


          # @user.errors.any?
          #   @user.errors.each do |key, value|
          #   end 
      end
    end
end

 def user_from_params
   params.require(:user).permit(:first_name, :last_name, :birthdate, :gender, :phone, :country, :email, :password)
 end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_from_params)
    redirect_to @user
  end


end
