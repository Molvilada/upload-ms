class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image
      t.text :image_base64

      t.timestamps
    end
  end
end
