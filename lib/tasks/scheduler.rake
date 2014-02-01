desc "This task is called by the Heroku scheduler add-on"
task :prompt => :environment do
  puts "Prompting..."
  Prompt.deliver
  puts "done."
end


desc "This task is called weekly"
task :summary => :environment do
  summary_data = Mood.summarize(8.days.ago, Time.now)
  Prompting.summary(summary_data).deliver
end