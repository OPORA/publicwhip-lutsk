require 'open-uri'

namespace :load_mp do
  desc "Load mp https://scrapermykolaivdeputy.herokuapp.com/"
  task :all => :environment do
    data_mps = JSON.load(open('https://scraperlutskdeputy.herokuapp.com/'))
    data_mps.each do |m|
      Mp.find_or_create_by(deputy_id: m["deputy_id"], first_name: m["first_name"], middle_name: m["middle_name"], last_name: m["last_name"], faction: m["faction"],  okrug: m["okrug"], end_date: m["end_date"])
    end
  end
  desc "Load picture image deputy"
  task :image => :environment do
    mps = JSON.load(open('https://scraperlutskdeputy.herokuapp.com/'))
    mps.each do |m|
      p m["photo_url"]
      photo = MiniMagick::Image.open(URI.encode(m["photo_url"]))
      photo.resize "200x200"
      photo.format 'png'
      photo.write("#{Rails.root}/public/image/#{m["deputy_id"]}.png")
    end
  end
end
