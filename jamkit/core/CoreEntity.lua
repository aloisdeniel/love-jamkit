local Parent = require("jamkit.ecs.Entity")
local Attached = require("jamkit.core.components.Attached")
local CoreEntity = class("CoreEntity", Parent)

function CoreEntity:initialize()
  Parent.initialize(self)
end

-- Parent entity

function Entity:attach(parentUid)
  assert((not self:has(Attached)), "entity is already attached to an other entity")
  local attached = Attached:new()
  attached.setParentId(parentUid)
  self:add(attached)
end

function Entity:dettach()
  self:remove(Attached)
end

function Entity:getParent()
  if self.components.attached then
    return self.components.attached.parent
  end
end

-- Bounds

function Entity:getBounds()
  return self.bounds.x, self.bounds.y, self.bounds.w, self.bounds.h
end

function Entity:setBounds(x,y,w,h)
  self.bounds.x, self.bounds.y, self.bounds.w, self.bounds.h = x,y,w,h
end

return CoreEntity