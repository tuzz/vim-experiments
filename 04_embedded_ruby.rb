# Demos some of Vim's API for Ruby.
# Run with :ruby load "04_embedded_ruby.rb"

# Set the current line.
Vim::Buffer.current.line = ">>> Hello, embedded Ruby!"

# Open a split by running something in normal mode.
Vim.command('exec "normal \<c-w>v"')
