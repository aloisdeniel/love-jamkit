local Parent = require("jamkit.ecs.Component")
local Body = class('Body',Parent)

function Body:initialize(width,height)
  Parent.initialize(self)
  self.addedToWorld = false
  self.store.group = nil
end

return Body