# Now that we know how to fork subprocesses, let's run a background server.
# Shame it's still noisy.

require "rack"

app = lambda do |_|
  [200, { "Content-Type" => "text/html" }, ["<h1>Hello, VimLondon!</h1>"]]
end

child = fork do
  Rack::Handler::WEBrick.run(app, :Port => 1234)
end

Process.detach(child)
