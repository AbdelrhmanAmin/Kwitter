class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
