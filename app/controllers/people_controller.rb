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
    mp_find = params[:mp].split("_")
    @mp = Mp.includes(:mp_info).where(last_name: mp_find[0], first_name: mp_find[1], middle_name: mp_find[2]).first
    if @mp
      @division_rebilions = Division.includes(:division_info).joins(:votes, :whips).where('votes.deputy_id =? and whips.party=?', @mp.deputy_id, @mp.faction ).where('votes.vote != whips.whip_guess and votes.vote != ?', "absent").order(date: :desc, id: :desc).references(:division_info).limit(5)
      @division = Division.includes(:division_info).joins(:votes, :whips).where('votes.deputy_id =? and whips.party=?', @mp.deputy_id, @mp.faction ).order(date: :desc, id: :desc).references(:division_info).limit(5)
      @friends = MpFriend.where(deputy_id: @mp.deputy_id).order(count: :desc).limit(5)
    else
      redirect_to people_path, :notice => "Не занйдено #{params[:mp]}"
    end
  end

  def divisions
    mp_find = params[:mp].split("_")
    @mp = Mp.includes(:mp_info).where(last_name: mp_find[0], first_name: mp_find[1], middle_name: mp_find[2]).first
    division = Division.includes(:division_info).joins(:votes, :whips).where('votes.deputy_id =? and whips.party=?', @mp.deputy_id, @mp.faction ).order(date: :desc, id: :desc).references(:division_info)
    @division =
        case params[:filter]
          when "rebellions"
          division.where('votes.vote != whips.whip_guess and votes.vote != ?', "absent").page params[:page]
          else
            division.page params[:page]
        end
  end

  def friends
    mp_find = params[:mp].split("_")
    @mp = Mp.includes(:mp_info).where(last_name: mp_find[0], first_name: mp_find[1], middle_name: mp_find[2]).first
    @friends = MpFriend.where(deputy_id: @mp.deputy_id).order(count: :desc)
  end
end
