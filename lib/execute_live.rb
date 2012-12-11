require "stringio"

module Kernel
  def execute_live(command,&block)
    if block
      old_stdout = STDOUT.clone
      reading_pipe, writing_pipe = IO.pipe
      reading_pipe.sync = true # Get new input immediately
      output = ""
      reader = Thread.new do
        begin
          loop do
            partial_output = reading_pipe.readpartial(1024)
            block.call(partial_output,old_stdout)
            output += partial_output
          end
        rescue EOFError
          # writing_pipe.close sends this signal
        end
      end
      # need to fork off because otherwise I can't use the regular STDOUT in the block
      # the child process defines its own STDOUT
      Process.fork do
        STDOUT.reopen(writing_pipe)
        system "#{command}"
        STDOUT.reopen(old_stdout)
      end
      Process.wait
      writing_pipe.close # Need to do that in the parent process, doesn't work in child process
      reader.join
      output
  else
    `#{command}`
  end
end
end
