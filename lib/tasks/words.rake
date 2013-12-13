desc "This task populates the terms table"
task :score_words => :environment do
  puts "Scoring known words"

  Mood::POSITIVE_WORDS.each do |word|
    Term.create(word: word, score: 1)
  end
  puts "Positive words done"

  Mood::NEGATIVE_WORDS.each do |word|
    Term.create(word: word, score: -1)
  end
  puts "Negative words done."
end
