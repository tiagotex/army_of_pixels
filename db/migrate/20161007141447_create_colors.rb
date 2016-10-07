class CreateColors < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.string :hex
      t.string :name
      t.string :normalized_name
      t.integer :user_id

      t.timestamps
    end
  end
end
