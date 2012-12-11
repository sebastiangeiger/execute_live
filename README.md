#execute_live

![Demo](https://raw.github.com/sebastiangeiger/execute_live/master/screencast.gif)

`execute_live` is an alternative for executing long running external commands.
It is aimed to be used in a similar way as backticks (`` ` ``) or `%x()`.
The twist to it is that you can pass it a block that gets invoked every time there is new output.

##usage
    execute_live("ping -c 3 google.com") do |new_output|
      puts "#{Time.now}: #{new_output}"
    end
    # >> 2012-12-11 22:17:06 +0100: PING google.com (173.194.69.113): 56 data bytes
         64 bytes from 173.194.69.113: icmp_seq=0 ttl=50 time=59.463 ms
         2012-12-11 22:17:07 +0100: 64 bytes from 173.194.69.113: icmp_seq=1 ttl=50 time=59.169 ms
         2012-12-11 22:17:08 +0100: 64 bytes from 173.194.69.113: icmp_seq=2 ttl=50 time=59.259 ms

         2012-12-11 22:17:08 +0100: --- google.com ping statistics ---
         3 packets transmitted, 3 packets received, 0.0% packet loss
         round-trip min/avg/max/stddev = 59.169/59.297/59.463/0.123 ms
