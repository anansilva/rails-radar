class NgosController < ApplicationController
  def index
    @ngos = Ngo.all
  end

  def show
  end
end
