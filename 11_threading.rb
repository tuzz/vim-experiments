# I wanted to see if I could make use of threads, so that Vim wouldn't hang.
# The short answer is no.
# The long answer is here:
# http://stackoverflow.com/questions/14002334/how-does-asynchronous-ruby-work-in-vim
# Basically, Vim giveth and taketh the Global Interpreter Lock.

print "Hello"
Thread.new do
  sleep 1
  print " world"
end
