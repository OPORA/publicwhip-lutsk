namespace :deputi_cashe do
  desc "Update mp cashe"
  task mp: :environment do
    Mp.all.each do |d|
      rebellions = Division.joins(:whips, :votes).where('votes.deputy_id = ?', d.deputy_id ).where('whips.party = ?', d.faction).where('votes.vote != whips.whip_guess').count

      v =  Vote.where(deputy_id: d.deputy_id).map {|v| v}
      hash = {
          not_voted: v.count{|v| v.vote == "not_voted"},
          absent: v.count{|v| v.vote == "absent"},
          against: v.count{|v| v.vote == "against"},
          aye: v.count{|v| v.vote == "aye"},
          abstain: v.count{|v| v.vote == "abstain"}
      }
      votes_possible = hash.sum{|k,v| v}
      votes_attended = votes_possible - hash[:absent]
      mp_info =MpInfo.find_or_initialize_by(deputy_id: d.deputy_id)
      mp_info.rebellions = rebellions
      mp_info.not_voted = hash[:not_voted]
      mp_info.absent = hash[:absent]
      mp_info.against = hash[:against]
      mp_info.aye_voted = hash[:aye]
      mp_info.abstain = hash[:abstain]
      mp_info.votes_possible = votes_possible
      mp_info.votes_attended = votes_attended
      mp_info.save
    end
  end

end
