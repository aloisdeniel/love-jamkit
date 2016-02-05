--- A component that renders something on the screen.
--
--### Extends : @{Component}
-- @classmod Renderer

local Parent = require("jamkit.ecs.Component")
local Renderer = class('Renderer',Parent)

function Renderer:initialize(image)
  Parent.initialize(self)
  self.store.order = 0
  self.store.x = 0
  self.store.y = 0
  self.store.w = 0
  self.store.h = 0
end

--- Gets all the boundaries.
-- @treturn number,number,number,number x,y,width,height of the boundaries.
function Renderer:getBounds()
  return self.store.x, self.store.y, self.store.w, self.store.h,
end

--- Sets all the boundaries.
-- @param[opt] x The top left corner x coordinate
-- @param[opt] y The top left corner y coordinate
-- @param[opt] w The width
-- @param[opt] h The height
-- @treturn number,number,number,number The x,y,width,height of the boundaries.
function Renderer:setBounds(x,y,w,h)
  x,y  = x or self.store.x, y or self.store.y
  w,h  = w or self.store.w, h or self.store.h
  self.store.x, self.store.y, self.store.w, self.store.h = x,y,w,h
  return x,y,w,h
end

return Renderer