class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :friend1_id
      t.integer :friend2_id
      t.string :status
      t.timestamps
    end
  end
end
