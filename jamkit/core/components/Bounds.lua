local Parent = require("jamkit.ecs.Component")
local Bounds = class('Bounds',Parent)

function Bounds:initialize()
  Parent.initialize(self)
  self.store.x = 0
  self.store.y = 0
  self.store.w = 0
  self.store.h = 0
end

return Bounds