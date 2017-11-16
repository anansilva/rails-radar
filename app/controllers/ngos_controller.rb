class NgosController < ApplicationController
  def new
    @user = current_user
    @ngo = Ngo.new
  end

  def create
    @user = current_user
    @ngo = NGO.new(ngo_params)
    @ngo.user = current_user

    if @ngo.save
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
  end

  private

  def ngo_params
    params.require(:ngo).permit(:name, :address, :lat, :lng)
  end
end
