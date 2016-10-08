class CreateStatus < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.integer :color_id
      t.integer :count

      t.timestamps
    end
  end
end
