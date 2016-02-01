-- Require Build
package.path = [[../../?.lua;]]..package.path

love.graphics.setDefaultFilter( 'nearest', 'nearest' )

function love.load()
  jamkit.inputs.register("right", { "right" }, {10,10,10,10})
  jamkit.inputs.register("left", { "left" }, {10,10,10,10})
end

function love.update(dt)
  
end

function love.draw()
  love.graphics.printf("Work in progress ...",50,50)
end
