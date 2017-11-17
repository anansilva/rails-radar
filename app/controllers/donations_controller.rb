class DonationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @ngo = Ngo.find(params[:ngo_id])
    @donation = Donation.new

    @hash = Gmaps4rails.build_markers(@ngo) do |ngo, marker|
      marker.lat ngo.latitude
      marker.lng ngo.longitude
    end
	end

	def create
    @ngo = Ngo.find(params[:ngo_id])
    @donation = Donation.new(donation_params)
    @donation.ngo = Ngo.find(params[:ngo_id])
    @donation.user = current_user

    if @donation.save
     redirect_to controller: "users", action: "show", id: "#{current_user.id}"
   else
     render :new
   end
 end



private

def donation_params
  params.require(:donation).permit(:type_id, :schedule, :address, :items, :comments)
end
end


