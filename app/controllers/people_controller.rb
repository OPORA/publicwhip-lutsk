class PeopleController < ApplicationController
  def index
    @mps = Mp.where(end_date: nil)
  end

  def show
  end
end
