# I wanted to see if subprocesses could still interact with the Vim API.
# They can't, although the objects are available to them (it doesn't error).

fork do
  Vim::Buffer.current.line = "Hello, subprocess?"
end
