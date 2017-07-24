class DivisionsController < ApplicationController
  def index
    @divisions = division()
    respond_to do |format|
      format.html
      format.js
    end
  end
  def page
    @divisions_page = division()

    respond_to do |format|
      format.js
    end
  end
  def division
    if params[:per].nil?
      params[:per] = 5
    end
    divisions = Division.includes(:division_info)
    unless params[:divisions].blank?
      divisions = divisions.find_by_search_query(params[:divisions])
    end
    @divisions =
        case params[:sort]
          when "attendance"
            if params[:filter_min].nil?
              params[:filter_min] = 30
            end
            if params[:filter_max].nil?
              params[:filter_max] = 90
            end
            divi = divisions.to_a.find_all{|m| m.division_info.attendance_division.to_f >= params[:filter_min].to_f/100 and m.division_info.attendance_division.to_f <= params[:filter_max].to_f/100 }.sort_by{ |m| [-(m.division_info.attendance_division || -1), m.date, m.number ]}
            Kaminari.paginate_array(divi).page(params[:page]).per(params[:per])
          when "rebellions"
            if params[:filter_min].nil?
              params[:filter_min] = 20
            end
            if params[:filter_max].nil?
              params[:filter_max] = 90
            end
            divi =divisions.to_a.find_all{|m| m.division_info.rebellions_fraction.to_f >= params[:filter_min].to_f/100 and m.division_info.rebellions_fraction.to_f <= params[:filter_max].to_f/100 }.sort_by{ |m| [-(m.division_info.rebellions_fraction || -1), m.date, m.number ]}
            Kaminari.paginate_array(divi).page(params[:page]).per(params[:per])
          else
            divisions.order(date: :desc, number: :desc).page(params[:page]).per(params[:per])
        end
  end
  def show
    @divisions = Division.includes(:division_info).where(date: params[:date], number: params[:id])
    @whips = Whip.where(division_id: @divisions.first.id).order(:party)
    @voted = Vote.includes(:mp).where(division_id: @divisions.first.id).order('mps.faction').to_a.map{|v| {name: v.mp.full_name, url: v.mp.url_name,  vote: v.vote, party: v.mp.faction } }.group_by{|f| f[:party]}
  end
end
