# This example runs a web server in Vim's embedded Ruby.
# It's noisy, hangs and is hard to kill.

require "rack"

app = lambda do |_|
  [200, { "Content-Type" => "text/html" }, ["<h1>Hello, VimLondon!</h1>"]]
end

Rack::Handler::WEBrick.run(app, :Port => 1234)
