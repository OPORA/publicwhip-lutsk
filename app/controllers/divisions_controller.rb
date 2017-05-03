class DivisionsController < ApplicationController
  def index
    divisions = Division.includes(:division_info)
    @divisions =
        case params[:sort]
          when "attendance"
             divisions.order('division_infos.turnout desc', number: :desc).page params[:page]
          when "rebellions"
             divisions.order('division_infos.rebellions desc', number: :desc).page params[:page]
          when "subject"
             divisions.order(name: :asc, number: :desc).page params[:page]
          else
             divisions.order(date: :desc, number: :desc).page params[:page]
        end
  end

  def show
    @divisions = Division.includes(:division_info).where(date: params[:date], number: params[:id])
    @whips = Whip.where(division_id: @divisions.first.id).order(:party)
    @voted = Vote.includes(:mp).where(division_id: @divisions.first.id).order('mps.faction').to_a.map{|v| {name: v.mp.full_name, url: v.mp.url_name,  vote: v.vote, party: v.mp.faction } }.group_by{|f| f[:party]}
  end
end
