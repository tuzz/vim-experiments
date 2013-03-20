# I don't like typing filenames.
# This kind of "bootstrap" script is surprisingly useful.
#
# Run the bootstrap with :ruby load "05_bootstrap.rb"

Vim.command("command! R ruby load Vim::Buffer.current.name")
print "Bootstrapped. You can now run experiments with :R"
