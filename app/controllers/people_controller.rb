class PeopleController < ApplicationController
  def index
    mps = Mp.includes(:mp_info).where(end_date: nil)
    if params[:sort] == "faction"
      @mps = mps.order(:faction, :last_name, :first_name, :middle_name, :okrug)
    elsif params[:sort] == "distric"
      @mps = mps.order(:okrug, :last_name, :first_name, :middle_name, :faction)
    elsif params[:sort] == "rebellions"
      @mps = mps.to_a.sort_by{ |m| [-(m.mp_info.rebellions_fraction || -1), m.last_name, m.first_name, m.middle_name, m.faction, m.okrug ]}
    elsif params[:sort] == "attendance"
      @mps = mps.to_a.sort_by{ |m| [-(m.mp_info.attendance_fraction || -1), m.last_name, m.first_name, m.middle_name, m.faction, m.okrug ]}
    else
      @mps = mps.order(:last_name, :first_name, :middle_name, :faction, :okrug)
    end
  end

  def show
  end
end
