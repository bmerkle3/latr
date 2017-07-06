class RemoveColumnImageUrlFromMessages < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :image_url, :string
  end
end
