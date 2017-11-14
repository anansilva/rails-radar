class NgosController < ApplicationController
  def index
    if params[:query]
      @ngos = Ngo.search_by_name_and_address(params[:query])
    elsif params[:type]
      @ngos = Ngo.includes(:types).where(:types => {name: params[:type]})
    else
      @ngos = Ngo.all
    end
  end

  def show
    @ngo = Ngo.find(params[:id])
    @donation = Donation.new
  end
end
