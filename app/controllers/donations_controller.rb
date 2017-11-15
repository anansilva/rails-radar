class DonationsController < ApplicationController
  before_action :authenticate_user!

	def new
		@ngo = Ngo.find(params[:ngo_id])
		@donation = Donation.new

		# We want to enter date
		# we picked the date on the previous view
		# these values are stored in the param (rather in a complicated way :( )
		# Mary wants to access these value
		# and store them individually 
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
