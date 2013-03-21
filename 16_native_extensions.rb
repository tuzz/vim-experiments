# MRI Ruby is built in C.
# By extension, we can use C-extensions in Vim.
# Scene is one such example.

require "scene"

fork do
  Scene.display
end
