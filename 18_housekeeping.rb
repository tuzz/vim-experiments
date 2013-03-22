# I tried to kill the child process when Vim exits.
# Not really sure why this doesn't work.

child = fork do
  loop do
    File.open("foo", "a") { |f| f.puts "foo" }
    sleep 1
  end
end

Process.detach(child)

Vim.command("autocmd VimLeave * :ruby Process.kill('SIGTERM', #{child}")
