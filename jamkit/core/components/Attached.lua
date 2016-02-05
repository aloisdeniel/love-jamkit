--- A component that indicates that an entity is attached to another.
-- @classmod Attached

local Parent = require("jamkit.ecs.Component")
local Attached = class('Attached',Parent)

function Attached:initialize()
  Parent.initialize(self)
  self.store.parentUid = nil
  self.parent = nil
end

--- Gets the parent's unique identifier.
-- @return The parent unique identifier.
function Attached:getParentUid()
  return self.store.parentUid
end

--- Gets the parent entity.
-- @return The parent entity
function Attached:getParent()
  return self.parent
end

--- Sets to which other entity the owner's entity is attached to.
-- @param parent The entity to which this entity is attached to
function Attached:setParent(parent)
  self.parent = parent
  self.store.parentUid = parent.uid
end

return Attached