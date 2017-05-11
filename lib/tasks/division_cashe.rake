namespace :division_cashe do
  desc "Update party statistick"
  task whip: :environment do
    Division.all.find_each do |d|
      Vote.joins(:mp).where(division_id: d.id).to_a.group_by{|m| m.mp.faction}.each do |f|
        division = d.id
        faction = f[0]
        hash = {
            not_voted: f[1].count{|v| v.vote == "not_voted"},
            absent: f[1].count{|v| v.vote == "absent"},
            against: f[1].count{|v| v.vote == "against"},
            aye: f[1].count{|v| v.vote == "aye"},
            abstain: f[1].count{|v| v.vote == "abstain"}
        }
        whip_guess = hash.sort_by{|k,v| v}.last.first.to_s
        whip = Whip.find_or_initialize_by(division_id: division, party: faction)
        whip.aye_votes = hash[:aye]
        whip.no_votes = hash[:not_voted]
        whip.absent = hash[:absent]
        whip.against = hash[:against]
        whip.abstain = hash[:abstain]
        whip.whip_guess = whip_guess
        whip.save
      end
    end
  end

  desc "Update division statistic"
  task info: :environment do
    Division.all.find_each do |d|
      division = d.id
      v =  Vote.joins(:mp).where(division_id: d.id).map {|v| v}
      hash = {
          not_voted: v.count{|v| v.vote == "not_voted"},
          absent: v.count{|v| v.vote == "absent"},
          against: v.count{|v| v.vote == "against"},
          aye: v.count{|v| v.vote == "aye"},
          abstain: v.count{|v| v.vote == "abstain"}
      }
      possible_turnout = hash.sum{|k,v| v}
      turnout = possible_turnout - hash[:absent]
      rebellions = []
      v.group_by{|m| m.mp.faction}.each do |f|
        whip_guess = Whip.find_by(party: f[0], division_id: division).whip_guess
        rebellions << f[1].count{|v| v.vote != whip_guess and v.vote != "absent"}
      end
      division_info = DivisionInfo.find_or_initialize_by(division_id: division)
      division_info.aye_votes = hash[:aye]
      division_info.no_votes = hash[:not_voted]
      division_info.absent = hash[:absent]
      division_info.against = hash[:against]
      division_info.abstain = hash[:abstain]
      division_info.possible_turnout = possible_turnout
      division_info.turnout = turnout
      division_info.rebellions = rebellions.sum
      division_info.save
    end
  end
  desc "Cache party voted aye 50%+1"
  task party_voted: :environment do
    party = {}
    Whip.all.find_each do |w|
      size = (w.aye_votes + w.no_votes + w.absent + w.against + w.abstain)/2+1
      if w.aye_votes >= size
       if party.has_key?("#{w.party}")
         if party["#{w.party}"].has_key?("#{w.division.date.strftime("%Y-%m")}")
           party["#{w.party}"]["#{w.division.date.strftime("%Y-%m")}"] << 1
         else
           party["#{w.party}"]["#{w.division.date.strftime("%Y-%m")}"] = [1]
         end
       else
         party["#{w.party}"] = {
             w.division.date.strftime("%Y-%m") => [1]
         }
       end
      end
    end
    party.each do |p|
      p p[0]
      p[1].each do |d|
        p d[0]
        p d[1].size
      end
    end
  end
end
