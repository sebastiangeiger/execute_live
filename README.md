#execute_live

`execute_live` is an alternative for executing long running external commands.
It is aimed to be used in a similar way as backticks (`` ` ``) or `%x()`.

##usage
    execute_live("ping -c 3 google.com") do |new_output|
      puts "#{Time.now}: #{new_output}"
    end
