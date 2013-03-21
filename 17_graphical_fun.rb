# Run this example in the usual way.
# Modify the data below to change the animation's state whilst it's running.
# It'll accept valid colours, including red, #fff and rgb(100,25,50).

#---SPLIT

#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00
#f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00 #f00

#---SPLIT

require "scene"
require "css_color"

class Scene

  def get_state_from_vim
    file = File.read(__FILE__)
    data = file.split("#---SPLIT")[1]

    @state = data.split.map { |c| CSSColor.parse(c) }
  end

  def display
    get_state_from_vim
    step = 0.2

    (-1..0.9).step(step).each_with_index do |y, i|
      (-1..0.9).step(step).each_with_index do |x, j|

        color = @state[10 * i + j]
        glColor3f(color.r, color.g, color.b)

        glBegin(GL_POLYGON)
          glVertex3f(x, y, 0)
          glVertex3f(x, y + step, 0)
          glVertex3f(x + step, y + step, 0)
          glVertex3f(x + step, y, 0)
        glEnd

      end
    end
  end

end

fork do
  Scene.display
end
