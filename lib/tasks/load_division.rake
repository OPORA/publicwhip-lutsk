namespace :load_division do
  desc "Load votes"
  task :votes, [:from_date, :to_date] => :environment do |t, args|
    load_votes = JSON.load(open('http://lutskvoted.oporaua.org/votes_events/'))
    save_votes = Division.pluck(:date).uniq.to_a.map{|d| d.strftime('%Y-%m-%d')}
    load_votes.each do |date|
      url ="http://lutskvoted.oporaua.org/votes_events/#{date}"
      encoded_url = URI.encode(url)
      divisions = JSON.load(open(URI.parse(encoded_url)))
      divisions.each do |d|
        date_day = DateTime.parse(d[0]["date_vote"]).strftime("%F")
        next if save_votes.include?(date_day)
        division = Division.find_or_create_by(
            date: date_day,
            number: d[0]["number"],
            name: d[0]["name"],
            clock_time: DateTime.parse(d[0]["date_vote"]).strftime("%T"),
            result: d[0]["option"]
        )
        division.votes.destroy_all
        votes_mp = []
        p "Adeded deputy voted"
        d[1]["votes"].each do |r|
          votes_mp << r["voter_id"]
          division.votes.create(deputy_id: r["voter_id"], vote: r["result"])
        end
        p "Adeded deputy absent"
        Mp.where.not(deputy_id: votes_mp ).each do |m|
          division.votes.create(deputy_id: m.deputy_id, vote: "absent")
        end
      end
    end
  end
end
