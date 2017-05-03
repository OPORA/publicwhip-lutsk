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

  end
end
