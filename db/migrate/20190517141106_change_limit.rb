class ChangeLimit < ActiveRecord::Migration[5.2]
  def change
    change_column :images, :image_base64, :text, :limit => 1.gigabyte - 1
  end
end
