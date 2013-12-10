desc "This task is called by the Heroku scheduler add-on"
task :prompt => :environment do
  puts "Prompting..."
  Prompt.deliver
  puts "done."
end
