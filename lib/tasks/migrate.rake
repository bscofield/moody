desc "Migrate data"
task :emotions => :environment do
  Emotion.all.each do |emotion|
    moods = Mood.where(['UPPER(emotion) = ?', emotion.word]).update_all(['emotion_id = ?', emotion.id])
  end
  puts "done."
end
