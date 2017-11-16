class NgosController < ApplicationController
  def new
    @user = current_user
    @ngo = Ngo.new
  end

  def create
    @user = current_user
    @ngo = Ngo.new(ngo_params)
    @ngo.lat = Geocoder.coordinates((params[:ngo][:address])).first
    @ngo.lng = Geocoder.coordinates((params[:ngo][:address])).last

    if @ngo.save
      @user.update(ngo_id: @ngo.id)
      redirect_to controller: "users", action: "show", id: "#{current_user.id}"
    else
      render :new
    end
  end

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

    @hash = Gmaps4rails.build_markers(@ngo) do |ngo, marker|
      marker.lat ngo.lat
      marker.lng ngo.lng
    end
  end

  def dashboard
    @ngo = Ngo.find(params[:id])
    @donations = @ngo.donations.reverse
  end

  private

  def ngo_params
    params.require(:ngo).permit(:user_id, :name, :address, :types, :lat, :lng)
  end
end
