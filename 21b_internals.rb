# It doesn't really matter how this actually works.
# But you wouldn't be here otherwise.
#
# We create the concept of a queue of prints / commands.
# Vim's module writes to this queue, then outputs to a file.
# An autocommand is setup that reads and executes the queue.
#
# The boilerplate of detaching the process and killing the child is
# abstracted away into a background method, that yields for our domain logic.

require "fileutils"

module StubApi
  $queue = []

  def print(s)
    $queue << [:print, s]
    write_queue
  end

  module ::Vim
    class << self
      alias :sync_command :command
      def command(c)
        $queue << [:sync_command, c]
        write_queue
      end
    end
  end

  # etc
end

def write_queue
  File.open("vimqueue", "w") { |f| f.puts Marshal.dump($queue) }
end

def read_queue
  Marshal.load(File.read("vimqueue")) rescue []
end

def remove_queue
  FileUtils.rm_f("vimqueue")
end

def execute_queue
  q = read_queue
  q.each do |method, args|
    Vim.send(method, args)
  end
  remove_queue
end

def background(&block)
  child = fork do
    include StubApi
    yield
  end
  Process.detach(child)
  Vim.sync_command("autocmd VimLeave * !kill -9 #{child}")
  Vim.sync_command("autocmd CursorMoved * ruby execute_queue")
end
