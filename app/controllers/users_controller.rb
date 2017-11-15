class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
   @donations = @user.donations.reverse
  end
end
