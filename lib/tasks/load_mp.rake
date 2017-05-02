require 'open-uri'

namespace :load_mp do
  desc "Load mp http://lvivmp.oporaua.org/"
  task :all => :environment do
    data_mps = JSON.load(open('http://lvivmp.oporaua.org/'))
    data_mps.each do |m|
      Mp.find_or_create_by(deputy_id: m["deputy_id"], first_name: m["first_name"], middle_name: m["middle_name"], last_name: m["last_name"], faction: m["faction"],  okrug: m["okrug"], end_date: m["end_date"])
    end
  end
  desc "Load picture image deputy"
  task :image => :environment do
    mps = JSON.load(open('http://lvivmp.oporaua.org/'))
    mps.each do |m|
      photo = MiniMagick::Image.open(URI.encode(m["photo_url"]))
      photo.format 'png'
      photo.write("#{Rails.root}/public/image/#{m["deputy_id"]}.png")
    end
  end
end
