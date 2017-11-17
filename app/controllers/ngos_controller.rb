class NgosController < ApplicationController
  def new
    @user = current_user
    @ngo = Ngo.new
  end

  def create
    @user = current_user
    @ngo = Ngo.new(ngo_params)

    types = params[:ngo][:type_ids]
    size = params[:ngo][:type_ids].size

    if @ngo.save
      @user.update(ngo_id: @ngo.id)

      (1...size).each do |t|
        a = NgoType.create(ngo_id: @ngo.id, type_id: types[t])
      end

      redirect_to controller: "ngos", action: "dashboard", id: "#{@ngo.id}"
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
      marker.lat ngo.latitude
      marker.lng ngo.longitude
      # marker.picture ({ url: "https://i.imgur.com/B0Q6ghF.png"})
    end
  end

  def show
    @ngo = Ngo.find(params[:id])
    @donation = Donation.new

    @hash = Gmaps4rails.build_markers(@ngo) do |ngo, marker|
      marker.lat ngo.latitude
      marker.lng ngo.longitude
    end
  end

  def dashboard
    if current_user.ngo_id.to_s == params[:id]
      @user = current_user
      @ngo = Ngo.find(params[:id])
      @donations = @ngo.donations.reverse
    else
      redirect_to controller: 'ngos', action: 'unauthorized', id: params[:id]
    end
  end

  def unauthorized
    @user = current_user
    @ngo = Ngo.find(params[:id])
  end

  def destroy
    ngo = Ngo.find(params[:id])
    ngo.destroy
    redirect_to controller: 'users', action: 'show', id: current_user.id
  end

  private

  def ngo_params
    params.require(:ngo).permit(:user_id, :name, :address, :lat, :lng)
  end
end


