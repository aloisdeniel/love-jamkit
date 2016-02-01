local Parent = require("jamkit.ecs.Component")
local Position = class('Position',Parent)

function Position:initialize()
  Parent.initialize(self)
  self.store.x = 0
  self.store.y = 0
  self.store.friction = 0
  self.store.velocity = { x=0, y=0 }
  self.store.acceleration = { x=0, y=0 }
end

-- Value

function Position:set(x,y)
  self.store.x, self.store.y = x,y
end

function Position:get()
  return self.store.x, self.store.y
end

function Position:_getParentValue()
  local entity = self.getEntity()
  if entity then
    local parent = entity.getParent()
    if parent and parent.components.position then
      return parent.components.position:get()
    end
  end
  return 0,0
end

function Position:setAbsolute(x,y)
  local px,py = self:_getParentValue()
  self:set(x - px, y - py)
end

function Position:getAbsolute()
  local x,y = self:get()
  local px,py = self:_getParentValue()
  return x + px, y + py
end

-- Velocity

function Position:setVelocity(x,y)
  self.store.velocity.x, self.store.velocity.y = x,y
end

function Position:getVelocity()
  return self.store.velocity.x, self.store.velocity.y
end

-- Acceleration

function Position:setAcceleration(x,y)
  self.store.acceleration.x, self.store.acceleration.y = x,y
end

function Position:getAcceleration()
  return self.store.acceleration.x, self.store.acceleration.y
end

return Position