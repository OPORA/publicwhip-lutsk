namespace :deputi_cashe do
  desc "Update mp cashe"
  task mp: :environment do
    Mp.all.each do |d|
      rebellions = Division.joins(:whips, :votes).where('votes.deputy_id = ?', d.deputy_id ).where('whips.party = ?', d.faction).where("votes.vote != 'absent'").where('votes.vote != whips.whip_guess').count

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
  desc "Update mp friend cashe"
  task friends: :environment do
    Mp.all.find_each do |m1|
     sql = %Q{
     SELECT
      votes2.deputy_id, count(*)
     FROM
      public.votes AS votes1
     LEFT JOIN
      public.votes AS votes2 ON votes1.division_id = votes2.division_id AND votes1.vote = votes2.vote AND votes1.deputy_id != votes2.deputy_id
     WHERE
      votes1.deputy_id = #{m1.deputy_id} AND votes2.deputy_id is not null AND votes1.vote != 'absent'
     GROUP BY
      votes2.deputy_id
      }
      ActiveRecord::Base.connection.execute(sql).each do |q|
        friend = MpFriend.find_or_initialize_by(deputy_id:  m1.deputy_id, friend_deputy_id: q["deputy_id"])
        friend.count = q["count"]
        friend.save
      end
    end
  end
end
