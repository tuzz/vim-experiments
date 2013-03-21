# Now that we know how to fork subprocesses, let's run a background server.

require "rack"
require "rack/source"

# Syntax highlight this file.
app = Rack::Source.new(__FILE__, lexer: :ruby)

child = fork do
  Rack::Handler::WEBrick.run(
    app,
    AccessLog: [], # This just keeps WEBrick quiet.
    Logger: WEBrick::Log::new("/dev/null", 7),
    Port: 1234
  )
end

Process.detach(child)
