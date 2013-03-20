# So we can't use threads. What about forking new processes?
# This actually words.

child = fork do
  1.upto(1000) do |i|
    # Every second, append a new number to out.txt
    File.open("out.txt", "a") { |f| f.puts i }
    sleep 1
  end
end

# Register disinterest in the child.
# This lets us run the process in the background.
Process.detach(child)

# You can actually quit Vim now, and it'll keep going.
# You have to kill -9 the zombied Vim process to stop it!
