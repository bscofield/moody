class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :word
      t.integer :score

      t.timestamps
    end

    add_index :terms, :word, unique: true
  end
end
