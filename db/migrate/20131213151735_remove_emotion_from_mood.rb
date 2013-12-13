class RemoveEmotionFromMood < ActiveRecord::Migration
  def change
    remove_column :moods, :emotion
  end
end
