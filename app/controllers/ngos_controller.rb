class NgosController < ApplicationController
  def index
  end

  def show
    @ngo = Ngo.new
  end
end
