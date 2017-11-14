class DonationsController < ApplicationController
	def create
		@donation = Donation.new
	end
end
