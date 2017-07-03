class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :caption
      t.string :image_url
      t.integer :sender_id
      t.integer :receiver_id
      t.datetime :deliver_at
      t.boolean :deliverable
      t.timestamps
    end
  end
end
