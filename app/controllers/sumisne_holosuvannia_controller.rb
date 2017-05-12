class SumisneHolosuvanniaController < ApplicationController
  def init

  end
  def api
    @vote = VoteFaction.order(vote_aye: :desc).map{|v| {faction: v.faction, date: v.date.strftime('%Y-%m'), vote_aye: v.vote_aye}}
    render :json => @vote
  end
end
