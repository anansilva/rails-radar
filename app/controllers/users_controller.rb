class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
   @donations = @user.donations.reverse
   @ngos = []

   @donations.each do |d|
    @ngos.push(Ngo.find(d.ngo_id))
   end

   @ngos = @ngos.uniq.compact
  end
end
