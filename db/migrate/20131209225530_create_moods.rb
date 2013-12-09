class CreateMoods < ActiveRecord::Migration
  def change
    create_table :moods do |t|
      t.datetime :recorded_at
      t.string :emotion
      t.text :notes

      t.timestamps
    end
  end
end
