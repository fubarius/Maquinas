class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
    create_table :authentications do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.json :info
      t.json :credentials
      t.json :extra
      t.belongs_to :user, foreign_key: true

      t.timestamps
      t.index [:provider, :uid], unique: true
    end
  end
end
