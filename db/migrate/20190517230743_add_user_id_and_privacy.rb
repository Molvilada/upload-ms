class AddUserIdAndPrivacy < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :privacy, :boolean 
    add_column :images, :id_user, :string
  end
end
