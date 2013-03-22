# This is one workaround that lets child processes print.
# It patches print inside the child to write to a file.
# An autcommand is registered that reads from the file and prints.
# The autocommand only triggers on cursormoved, but there are better methods:
# http://vim.wikia.com/wiki/Have_Vim_check_automatically_if_the_file_has_changed_externally

require "fileutils"

child = fork do
  # Patch print to write to a file.
  def print(s)
    File.open("vimprint", "a") { |f| f.puts s }
  end

  def fib(n)
    n <= 2 ? 1 : fib(n - 1) + fib(n - 2)
  end

  1.upto(50) do |i|
    print "fib(#{i}) = #{fib(i)}"
    sleep 1
  end
end

Process.detach(child)

# Read the vimprint file and actually print the results.
def print_from_child
  prints = File.read("vimprint")
  prints.split("\n").each { |p| print p }
  FileUtils.rm("vimprint")
rescue
end

Vim.command("autocmd CursorMoved * ruby print_from_child")
