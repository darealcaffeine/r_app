class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]  
  before_filter :admin_user,   :only => [:destroy, :toggle]

  def show
    @user=User.find(params[:id])
    @title=@user.name
  end
 

  def new
    if self.signed_in?
       redirect_to (root_path)
    end
    @user = User.new
    @title = "Sign up"

  end

  def create

    if self.signed_in?
       redirect_to (root_path)
    end
 
    @user = User.new(params[:user])
    if @user.save
    sign_in @user
    flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
 
  
  end


  
  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
       flash[:success] = "Profile updated."
       redirect_to @user
    else
     @title = "Edit user"
     render 'edit'
    end
  end
 
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts= @user.microposts.paginate(:page => params[:page])
    @title = @user.name
  end

  def destroy
    if current_user.admin?
       if User.find(params[:id])==current_user
          redirect_to users_path
          flash[:fail] = "Cannot delete Admin"
      else      
          User.find(params[:id]).destroy 
          flash[:success] = "User destroyed."
          redirect_to users_path
      end
    end


    def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(:page => params[:page])
      @title = @user.name
    end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end

#    def toggle 
#      User.find(params[:id]).admin = true      

       # @user.toggle! (:admin)
 #       if  User.admin?
  #      flash[:success] = User.name "is now an Adminstrator."
   #     redirect_to users_path
    #    end
  #  end
  
#     def deny_delete
 #      if User.find(params[:id])==current_user
  #     redirect_to users_path
   #   flash[:fail] = "Cannot delete Admin"
 #  end
  end

  private

    def authenticate
      deny_access unless signed_in?
    end
   
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
     def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
