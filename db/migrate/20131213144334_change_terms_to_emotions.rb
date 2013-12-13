class ChangeTermsToEmotions < ActiveRecord::Migration
  def change
    rename_table :terms, :emotions
  end
end
