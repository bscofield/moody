class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.datetime :requested_at
      t.datetime :responded_at

      t.timestamps
    end
  end
end
