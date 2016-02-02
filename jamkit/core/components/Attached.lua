local Parent = require("jamkit.ecs.Component")
local Bounds = class('Bounds',Parent)

function Bounds:initialize()
  Parent.initialize(self)
  self.store.parentId = nil
  self.parent = nil
end

function Bound:setParentId(id)
  assert(not self.store.parentId, "Already a parent identifier")
  self.store.parentId = id
end

function Bound:isParentAttached()
  return self.store.parentId and self.parent
end

return Bounds