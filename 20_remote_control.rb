# This experiment runs a web application that can control Vim remotely.
# It writes to a vimremote file, which then gets picked up by an autocmd.
# Again, the autocmd only triggers on cursor moved.
# Nothing here is new. We're just pulling everything together.

require "rack"
require "cgi"
require "fileutils"

form = <<-HTML
<form name="input" action="/" method="get">
  Command: <input type="text" name="command">
  <input type="submit" value="Submit">
</form>
HTML

app = lambda do |env|
  if (q = env["QUERY_STRING"])
    command = CGI.unescape(q.sub("command=", ""))
    File.open("vimremote", "a") { |f| f.puts command }
  end

  [200, { "Content-Type" => "text/html" }, [form]]
end

child = fork do
  Rack::Handler::WEBrick.run(
    app,
    AccessLog: [],
    Logger: WEBrick::Log::new("/dev/null", 7),
    Port: 1234
  )
end

def remote_command_execution
  commands = File.read("vimremote")
  FileUtils.rm("vimremote")
  commands.split("\n").each { |c| Vim.command(c) }
rescue
end

Process.detach(child)

Vim.command("autocmd CursorMoved * ruby remote_command_execution")
