class DivisionsController < ApplicationController
  def index
    @divisions = Division.all
  end

  def show

  end
end
