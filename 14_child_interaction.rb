# I wanted to see if subprocesses could still interact with the Vim API.
# They can't, although the objects are available to them (it doesn't error).

fork do
  Vim::Buffer.current.line = "Hello, subprocess?"
end

# This lets us reason about how the API works.
#
# Example, :ruby Vim::Buffer.current.line = "foo"
#
# 1. The API classes are initialized with Vim's current state.
# 2. The body of the command is executed until the process exits.
# 3. Vim inspects the state of the API classes and modifies Vim.
#
# Presumably, the API must push commands onto a FIFO queue.
# You could write the entire thing without FFI, or any hacks. Smart.
