--- A component that represents a physics box body of an entity.
--
--### Extends : @{Component}
-- @classmod Body

local Parent = require("jamkit.ecs.Component")
local Body = class('Body',Parent)

function Body:initialize(width,height)
  Parent.initialize(self)
  self.addedToWorld = false
  self.store.width = width
  self.store.height = height
  self.store.group = nil
end

--- Gets the dimensions of the body.
-- @return width, height of the body
function Body:getDimensions()
  return self.store.width, self.store.height
end

--- Sets the dimensions of the body.
-- @int w The width of the body
-- @int h The height of the body
-- @treturn int,int The width, height of the body
function Body:setDimensions(w,h)
  self.store.width, self.store.height = w, h
  return w,h
end

return Body