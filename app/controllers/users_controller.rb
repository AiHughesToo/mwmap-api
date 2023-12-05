class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :create]
  before_action :authenticate_token!, except: [:password_reset, :index]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    if @current_user.account_type == "admin"
      @user = User.new(user_params)
  
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end
  
  # RESET password 
  def password_reset
    unless(user = User.find_by_email(user_params[:email])).nil?
      user.send_reset_password_instructions
      head :no_content
    else
      render json: {errors: 'You have not been found.'}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:f_name, :l_name, :password, :account_type, :email, :wp_user_id)
    end
end
