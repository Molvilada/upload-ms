class ChangeNameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :id_user, :iduser
  end
end
