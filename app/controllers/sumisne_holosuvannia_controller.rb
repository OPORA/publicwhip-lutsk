class SumisneHolosuvanniaController < ApplicationController
  def init
     if params[:month].nil? or params[:month].blank?
       params[:month] = "full"
     end
    if params[:party].nil? or params[:party].blank?
      params[:party] = "Блок Петра Порошенка"
    end
     @party = PartyFriend.pluck(:party).uniq
     @month = PartyFriend.order(date_party_friend: :desc).pluck(:date_party_friend).uniq
  end
  def api
    party = PartyFriend.pluck(:party).uniq
    if params[:month] == "full"
       @vote = PartyFriend.where(party: params[:party]).order(count: :desc).map{|v| {faction: v.friend_party, date: v.date_party_friend.strftime('%Y-%m'), vote_aye: v.count}}
    else
       @vote = PartyFaction.where(party: params[:party], date_party_friend: Date.strptime(params[:month], '%Y-%m')).order(count: :desc).map{|v| {faction: v.friend_party, date: v.date_party_friend.strftime('%Y-%m'), vote_aye: v.count}}
    end
    vote_party = @vote.map{|p| p[:faction]}
    party_not_voted = party.find_all{|v| vote_party.include?(v) == false }
    unless party_not_voted.blank?
    @vote =  @vote + party_not_voted.map{|p| {faction: p, date: @vote.last[:date], vote_aye: 0} }
    end
    render :json => @vote
  end
end
