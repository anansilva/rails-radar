class NgosController < ApplicationController
  def index
    @ngos = Ngo.all
  end

  def show
    @ngo = Ngo.find(params[:id])
    @donation = Donation.new
  end
end
