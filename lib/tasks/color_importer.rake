namespace :color_importer do
  desc "Imports colors"
  task run: :environment do
    YAML.load_file(Rails.root.join('config', 'data', 'colors.yml')).each do |color, name|
      Color.new(hex: color, name: name, normalized_name: name.gsub(' ', '').underscore)
    end
  end
end
