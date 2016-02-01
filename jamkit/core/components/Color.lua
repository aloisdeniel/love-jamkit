local Parent = require("jamkit.ecs.Component")
local Color = class('Color',Parent)

function Color:initialize()
  Parent.initialize(self)
  self.store.r = 255
  self.store.g = 255
  self.store.b = 255
  self.store.a = 255
end

-- Relative

function Color:set(r,g,b,a)
  self.store.r, self.store.g, self.store.b, self.store.a = r or 255,g or 255,b or 255,a or 255
end

function Color:get()
  return self.store.r, self.store.g, self.store.b, self.store.a
end

-- Absolute

function Color:_getParentValue()
  local entity = self.getEntity()
  if entity then
    local parent = entity.getParent()
    if parent and parent.components.color then
      return parent.components.color:get()
    end
  end
  return 255,255,255,255
end

function Color:setAbsolute(r,g,b,a)
  local pr,pg,pb,pa = self:_getParentValue()
  r = (r / pr) * 255
  g = (g / pg) * 255
  b = (b / pb) * 255
  a = (a / pa) * 255
  self:set(x - px, y - py)
end

function Color:getAbsolute()
  local r,g,b,a = self:get()
  local pr,pg,pb,pa = self:_getParentValue()
  r = (r * pr) / 255
  g = (g * pg) / 255
  b = (b * pb) / 255
  a = (a * pa) / 255
  return r,g,b,a
end

-- Velocity

function Rotation:setVelocity(r,g,b,a)
  self.velocity = a
end

function Rotation:getVelocity()
  return self.velocity
end

-- Acceleration

function Rotation:setAcceleration(a)
  self.acceleration = a
end

function Rotation:getAcceleration()
  return self.acceleration
end

return Color