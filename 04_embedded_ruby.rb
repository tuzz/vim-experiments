# Demos some of Vim's API for Ruby.
# Run with :ruby load "04_embedded_ruby.rb"

Vim::Buffer.current.line = ">>> Hello, embedded Ruby!"

cursor = Vim::Window.current.cursor
Vim::Buffer.current.append(5, ">>> Cursor at: #{cursor.inspect}")
