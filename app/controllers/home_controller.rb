class HomeController < ApplicationController
  def index
    @mps = Mp.order(last_name: :asc).map{|m| m.last_name + " " + m.first_name + " " + m.middle_name}
  end
  def search_mp
    mp = params[:mp].gsub(" ", "_")
    redirect_to show_people_path(mp)
  end
end
