class RemoveUserIdFromColors < ActiveRecord::Migration[5.0]
  def change
    remove_column :colors, :user_id, :string
  end
end
