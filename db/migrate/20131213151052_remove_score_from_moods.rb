class RemoveScoreFromMoods < ActiveRecord::Migration
  def change
    remove_column :moods, :score
    add_column :moods, :emotion_id, :integer
  end
end
