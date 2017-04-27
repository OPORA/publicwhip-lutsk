class HomeController < ApplicationController
  def index
    @mps = Mp.order(last_name: :asc).map{|m| m.first_name + " " + m.last_name}
  end
  def search_mp

  end
end
