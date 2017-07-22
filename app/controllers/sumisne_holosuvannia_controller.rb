class SumisneHolosuvanniaController < ApplicationController
  def init
     if params[:month].nil? or params[:month].blank?
       params[:month] = "full"
     end
    if params[:party].nil? or params[:party].blank?
      params[:party] = "Блок Петра Порошенка"
    end
     @party = VoteFaction.pluck(:faction).uniq
     @month = VoteFaction.pluck(:date).uniq
  end
  def api
    if params[:month] == "full"
       @vote = VoteFaction.order(vote_aye: :desc).map{|v| {faction: v.faction, date: v.date.strftime('%Y-%m'), vote_aye: v.vote_aye}}
    else
       @vote = VoteFaction.where(date: Date.strptime(params[:month], '%Y-%m')).order(vote_aye: :desc).map{|v| {faction: v.faction, date: v.date.strftime('%Y-%m'), vote_aye: v.vote_aye}}
    end
    render :json => @vote
  end
end
