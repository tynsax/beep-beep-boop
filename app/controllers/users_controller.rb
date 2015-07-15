class UsersController < ApplicationController

  def profile
    @user = current_user

    if params.include?(:user)
      @user.update(user_params)
      flash[:success] = 'Updated!'
    end
  end

  def user_params
    params.require(:user).permit(:phone, :name)
  end
end
