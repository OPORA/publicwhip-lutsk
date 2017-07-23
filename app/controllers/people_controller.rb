class PeopleController < ApplicationController
  def index
    mps = Mp.includes(:mp_info).where(end_date: nil)
    @mp = mps.order(:last_name)
    if params[:sort] == "faction"
      @filter = mps.order(:faction).map{|m| m.faction }.uniq
      if params[:filter].nil?
        params[:filter] = @filter.first
      end
    elsif params[:sort] == "distric"
      @filter = mps.order(:okrug).map{|m| m.okrug }.uniq.compact
      if params[:filter].nil?
        params[:filter] = @filter.first
      end
    elsif params[:sort] == "rebellions"
      if params[:filter_min].nil? or params[:filter_min].blank?
        params[:filter_min] = 30
      end
      if params[:filter_max].nil? or params[:filter_max].blank?
        params[:filter_max] = 90
      end
    elsif params[:sort] == "attendance"
      if params[:filter_min].nil? or params[:filter_min].blank?
        params[:filter_min] = 30
      end
      if params[:filter_max].nil? or params[:filter_max].blank?
        params[:filter_max] = 90
      end
    else
      @filter = mps.order(:last_name).map{|m| m.last_name[0] }.uniq
      if params[:filter].nil?
        params[:filter] = @filter.first
      end
    end
    @mps = mps()
    respond_to do |format|
      format.html
      format.js
    end
  end
  def mps
    if params[:per].nil?
      params[:per] = 8
    end
    mps = Mp.includes(:mp_info).where(end_date: nil)
    if params[:sort] == "faction"
      @mps = mps.where(faction: params[:filter]).order(:faction, :last_name, :first_name, :middle_name, :okrug).page(params[:page]).per(params[:per])
    elsif params[:sort] == "distric"
      @mps = mps.where(okrug: params[:filter]).order(:okrug, :last_name, :first_name, :middle_name, :faction).page(params[:page]).per(params[:per])
    elsif params[:sort] == "rebellions"
      mpls = mps.to_a.find_all{|m| m.mp_info.rebellions_fraction.to_f >= params[:filter_min].to_f/100 and m.mp_info.rebellions_fraction.to_f <= params[:filter_max].to_f/100 }.sort_by{ |m| [-(m.mp_info.rebellions_fraction || -1), m.last_name, m.first_name, m.middle_name, m.faction, m.okrug ]}#params[:filter_max].to_f/100}#
    elsif params[:sort] == "attendance"
      mpls = mps.to_a.find_all{|m| m.mp_info.attendance_fraction.to_f >= params[:filter_min].to_f/100 and m.mp_info.attendance_fraction.to_f <= params[:filter_max].to_f/100 }.sort_by{ |m| [-(m.mp_info.attendance_fraction || -1), m.last_name, m.first_name, m.middle_name, m.faction, m.okrug ]}
    else
      @mps = mps.where("last_name like ?", params[:filter] + "%" ).order(:last_name, :first_name, :middle_name, :faction, :okrug).page(params[:page]).per(params[:per])
    end
    if mpls
      @mps = Kaminari.paginate_array(mpls, total_count: mpls.size).page(params[:page]).per(params[:per])
    end
    return @mps
  end
  def page
    @mps = mps()
    respond_to do |format|
      format.js
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
