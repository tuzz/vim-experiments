# This experiment investigates how we can abstract complexities away.
# I'd rather not have to worry about killing processes, or reading from files.
# The complexities are hidden away in 21b_internals.
# This file is the domain logic for a simple example.

$LOAD_PATH.unshift(File.dirname(__FILE__))
require "21b_internals"

background do
  1.upto(10) do |i|
    print i
    sleep 1
  end

  print "Splitting"
  Vim.command("vs")
end
