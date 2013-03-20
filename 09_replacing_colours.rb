# This example goes through every word of every line.
# If the css_color gem recognises the word as a colour,
# it is replaced by that colour (in hex).

# The key thing here is that we can use gems quite happily inside Vim.

require "css_color"

buffer = Vim::Buffer.current
lines  = buffer.length

1.upto(lines) do |i|
  words = buffer[i].split
  words.each do |word|
    begin
      color = CSSColor.parse(word)
      buffer[i] = buffer[i].gsub(word, color.html)
    rescue CSSColor::UnknownColorError
    end
  end
end


# ================
# Watch this space
# ================

# one red two blue three four
# rgb(0,0,0) five rgb(100,25,0)
# six #ffff00 #f0f
