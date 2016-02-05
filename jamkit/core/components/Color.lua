--- A component that represents the current color of an entity.
-- @classmod Color

local Parent = require("jamkit.ecs.Component")
local Color = class('Color',Parent)

function Color:initialize()
  Parent.initialize(self)
  self.store.r = 255
  self.store.g = 255
  self.store.b = 255
  self.store.a = 255
  self.store.velocity = {r=0,g=0,b=0,a=0}
  self.store.acceleration = {r=0,g=0,b=0,a=0}
end

--- @section Value

--- Sets the color.
-- @param r The red component
-- @param g The green component
-- @param b The blue component
-- @param a The alpha component
-- @return The r,g,b,a components after modification
function Color:set(r,g,b,a)
  self.store.r = math.max(0,math.min(255,r or 255))
  self.store.g = math.max(0,math.min(255,g or 255))
  self.store.b = math.max(0,math.min(255,b or 255))
  self.store.a = math.max(0,math.min(255,a or 255))
  return self:get()
end

--- Gets the color.
-- @return r,g,b,a components.
function Color:get()
  return self.store.r, self.store.g, self.store.b, self.store.a
end

--- Adds values to current position coordinates.
-- @param r The value add to red component
-- @param g The value add to green component
-- @param b The value add to blue component
-- @param a The value add to alpha component
-- @param delta *(optional)* A factor applied to added values
-- @return The r,g,b,a components after modification
function Color:add(r,g,b,a,delta)
  delta = delta or 1
  a = a or 0
  r = r or 0
  g = g or r
  b = b or r
  local cr,cg,cb,ca = self:get()
  self:set(cr+(r*delta),cg+(g*delta),cb+(b*delta),ca+(a*delta))
  return self:get()
end

--- @section Velocity

--- Sets the current velocity.
-- @param r The red component velocity
-- @param g The green component velocity
-- @param b The blue component velocity
-- @param a The alpha component velocity
-- @return The velocity after modification
function Rotation:setVelocity(r,g,b,a)
  local vel = self.store.velocity
  vel.r = a or 0
  vel.r = r or 0
  vel.g = g or r
  vel.b = b or r
  return self:getVelocity()
end

--- Gets the current velocity.
-- @return x,y coordinate velocities
function Rotation:getVelocity()
  local vel = self.store.velocity
  return vel.r,vel.g,vel.b,vel.a
end

--- @section Acceleration

--- Sets the current acceleration.
-- @param r The red component acceleration
-- @param g The green component acceleration
-- @param b The blue component acceleration
-- @param a The alpha component acceleration
-- @return The acceleration after modification
function Rotation:setAcceleration(r,g,b,a)
  local acc = self.store.acceleration
  acc.r = a or 0
  acc.r = r or 0
  acc.g = g or r
  acc.b = b or r
  return self:getAcceleration()
end

--- Gets the current acceleration.
-- @return r,g,b,a components accelerations
function Rotation:getAcceleration()
  local acc = self.store.acceleration
  return acc.r,acc.g,acc.b,acc.a
end

--[[ -- Must be in systems (Absolute)
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
end ]]

return Color