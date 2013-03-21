# A few attempts to get pry working - failed.
# I wanted to use its show-source feature on the Ruby API.
# This would let me see where the state is stored for API calls.
# I could then potentially Marshal.dump this state to a file.
# And pick it up by a new parent process that gets called by a Vim autocmd.

# fails due to no .tty? method on Object.
require 'pry'
binding.pry 

# I tried stubbing out puts on Object.
# This seemed to be where it was calling .tty? from.

require 'pry'
class Object
  def puts(foo)
  end
end
binding.pry

# Still no luck. :-(
