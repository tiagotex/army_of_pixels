namespace :cron do
  desc "Update status"
  task update_status: :environment do
    Status.transaction do
      Color.where('users_count > 0').each do |color|
        Status.create(color_id: color.id, count: color.users_count)
      end
    end
  end
end
