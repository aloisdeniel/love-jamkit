--- A component that represents the visual bounds of an entity.
-- @classmod Bounds

local Parent = require("jamkit.ecs.Component")
local Bounds = class('Bounds',Parent)

function Bounds:initialize()
  Parent.initialize(self)
  self.store.x = 0
  self.store.y = 0
  self.store.w = 0
  self.store.h = 0
end

--- Gets all the boundaries.
-- @return x,y,width,height of the boundaries.
function Bounds:get()
  return self.store.x, self.store.y, self.store.w, self.store.h,
end

return Bounds