class AddColorsCount < ActiveRecord::Migration[5.0]
  def change
    add_column :colors, :users_count, :integer, default: 0

    reversible do |dir|
      dir.up do
        Color.reset_column_information
        Color.all.each do |color|
          Color.update_counters color.id, :users_count => color.users.length
        end
      end
    end
  end
end
