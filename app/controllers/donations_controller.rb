class DonationsController < ApplicationController
	def new
		@ngo = Ngo.find(params[:id])
	end

	def create
		@donation = Donation.new
	end
end
