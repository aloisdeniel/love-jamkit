--- A component that represents the rotation of an entity.
-- @classmod Rotation

local Parent = require("jamkit.ecs.Component")
local Rotation = class('Rotation',Parent)

function Rotation:initialize()
  Parent.initialize(self)
  self.store.angle = 0
  self.store.friction = 0
  self.store.velocity = 0
  self.store.acceleration = 0
end

-- Relative

function Rotation:set(a)
  self.store.angle = a
end

function Rotation:get()
  return self.store.angle
end

-- Absolute

function Rotation:_getParentValue()
  local entity = self.getEntity()
  if entity then
    local parent = entity.getParent()
    if parent and parent.components.rotation then
      return parent.components.rotation:get()
    end
  end
  return 0
end

function Rotation:setAbsolute(a)
  local pa = self:_getParentValue()
  self:set(a - pa)
end

function Rotation:getAbsolute()
  local a = self:get()
  local pa = self:_getParentValue()
  return a + pa
end

-- Velocity

function Rotation:setVelocity(a)
  self.store.velocity = a
end

function Rotation:getVelocity()
  return self.store.velocity
end

-- Acceleration

function Rotation:setAcceleration(a)
  self.store.acceleration = a
end

function Rotation:getAcceleration()
  return self.store.acceleration
end

return Rotation