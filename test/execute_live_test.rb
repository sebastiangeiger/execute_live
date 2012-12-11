require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/execute_live'

describe "Kernel" do
  describe "#execute_live" do
    describe "with fast output" do
      it "returns the output when invoked without block" do
        execute_live("test/fast_command.sh").must_equal "Executing fast_command\n"
      end
      it "applies the block to the output" do
        recorder = ""
        execute_live("test/fast_command.sh") do |new_output|
          recorder += new_output.upcase
        end
        recorder.must_equal "EXECUTING FAST_COMMAND\n"
      end
      it "returns the output even when a block was given" do
        execute_live("test/fast_command.sh") do |new_output|
          new_output.upcase
        end.must_equal "Executing fast_command\n"
      end
    end
    describe "with slow output" do
      it "returns the output even when a block was given" do
        execute_live("test/slow_command.sh").must_equal "partial output 1\npartial output 2\npartial output 3\n"
      end
      it "applies the block to every new chunk of output" do
        recorder = ""
        i = 1
        execute_live("test/slow_command.sh") do |new_output|
          recorder += "#{i}: #{new_output}"
          i += 1
        end
        recorder.must_equal "1: partial output 1\n2: partial output 2\n3: partial output 3\n"
      end
    end
  end
end
