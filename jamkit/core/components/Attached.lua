--- A component that indicates that an entity is attached to another.
--
--### Extends : @{Component}
-- @classmod Attached

local Parent = require("jamkit.ecs.Component")
local Attached = class('Attached',Parent)

function Attached:initialize()
  Parent.initialize(self)
  self.store.parentUid = nil
  self.parent = nil
end

--- Gets the parent's unique identifier.
-- @treturn int The parent unique identifier.
function Attached:getParentUid()
  return self.store.parentUid
end

--- Sets the parent's unique identifier.
-- @int id The identifier of the parent entity.
-- @treturn int The parent unique identifier.
function Attached:setParentUid(id)
  self.store.parentUid = id
  return self.store.parentUid
end

--- Gets the parent entity.
-- @treturn Entity The parent entity
function Attached:getParent()
  return self.parent
end

--- Sets to which other entity the owner's entity is attached to.
-- @entity parent The entity to which this entity is attached to
-- @treturn Entity The parent entity
function Attached:setParent(parent)
  self.parent = parent
  self.store.parentUid = parent.uid
  return parent
end

return Attached