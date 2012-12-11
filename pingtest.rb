require_relative 'lib/execute_live.rb'

execute_live('ping -c 3 google.com') do |partial|
  puts "#{Time.now}: #{partial}"
end
