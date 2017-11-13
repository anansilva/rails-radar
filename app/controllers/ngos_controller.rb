class NgosController < ApplicationController
  def index
    @ngos = Ngo.all
  end

  def show
    @ngo = Ngo.new
  end
end
