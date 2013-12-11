class AddScoreToMoods < ActiveRecord::Migration
  def change
    add_column :moods, :score, :integer, default: 0
  end
end
