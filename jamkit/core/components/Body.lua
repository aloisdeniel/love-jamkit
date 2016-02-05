--- A component that represents a physics box body of an entity.
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

return Body