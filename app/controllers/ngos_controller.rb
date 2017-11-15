class NgosController < ApplicationController
  def index
    if params[:query]
      @ngos = Ngo.search_by_name_and_address(params[:query])
    elsif params[:type]
      @ngos = Ngo.includes(:types).where(:types => {name: params[:type]})
    else
      @ngos = Ngo.all
    end

    @hash = Gmaps4rails.build_markers(@ngos) do |ngo, marker|
      marker.lat ngo.lat
      marker.lng ngo.lng
      # marker.picture ({ url: "https://i.imgur.com/B0Q6ghF.png"})
    end
  end

  def show
    @ngo = Ngo.find(params[:id])
    @donation = Donation.new
  end
end
