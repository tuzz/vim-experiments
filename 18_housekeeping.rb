# This experiment demonstrates a way to kill the process when Vim exits.
# Initially, I tried ruby Process.kill("SIGTERM", #{child}).
# Not sure why that didn't work, but this does.

child = fork do
  loop do
    File.open("foo", "a") { |f| f.puts "foo" }
    sleep 1
  end
end

Process.detach(child)

Vim.command("autocmd VimLeave * !kill -9 #{child}")
