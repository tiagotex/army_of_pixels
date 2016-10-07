require 'net/http'

namespace :import do
  desc "Imports colors"
  task colors: :environment do
    YAML.load_file(Rails.root.join('config', 'data', 'colors.yml')).each do |color, name|
      Color.create(hex: color, name: name, normalized_name: name.gsub(' ', '').underscore)
    end
  end

  desc "Imports Users"
  task users: :environment do
    result = Net::HTTP.get(URI.parse('https://api.pixels.camp/users/?count=1000'))

    JSON.parse(result)['users'].each_with_index do |user, index|
      User.create(name: user['name'], username: user['login'], color_id: index+1)
    end
  end
end
