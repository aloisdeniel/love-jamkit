--- A component that represents the current color of an entity.
--
--### Extends : @{Component}
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
-- @int r The red component
-- @int g The green component
-- @int b The blue component
-- @int a The alpha component
-- @treturn int,int,int,int The r,g,b,a components after modification
function Color:set(r,g,b,a)
  self.store.r = math.max(0,math.min(255,r or 255))
  self.store.g = math.max(0,math.min(255,g or 255))
  self.store.b = math.max(0,math.min(255,b or 255))
  self.store.a = math.max(0,math.min(255,a or 255))
  return self:get()
end

--- Gets the color.
-- @treturn int,int,int,int r,g,b,a components.
function Color:get()
  return self.store.r, self.store.g, self.store.b, self.store.a
end

--- Adds values to current position coordinates.
-- @int[opt] r The value add to red component
-- @int[opt] g The value add to green component
-- @int[opt] b The value add to blue component
-- @int[opt] a The value add to alpha component
-- @number[opt] delta *(optional)* A factor applied to added values
-- @treturn int,int,int,int The r,g,b,a components after modification
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
-- @int[opt] r The red component velocity
-- @int[opt] g The green component velocity
-- @int[opt] b The blue component velocity
-- @int[opt] a The alpha component velocity
-- @treturn int,int,int,int The velocity after modification
function Rotation:setVelocity(r,g,b,a)
  local vel = self.store.velocity
  vel.r = a or 0
  vel.r = r or 0
  vel.g = g or r
  vel.b = b or r
  return self:getVelocity()
end

--- Gets the current velocity.
-- @treturn int,int,int,int The r,g,b,a component velocities
function Rotation:getVelocity()
  local vel = self.store.velocity
  return vel.r,vel.g,vel.b,vel.a
end

--- @section Acceleration

--- Sets the current acceleration.
-- @int r[opt] The red component acceleration
-- @int g[opt] The green component acceleration
-- @int b[opt] The blue component acceleration
-- @int a[opt] The alpha component acceleration
-- @treturn int,int,int,int The acceleration after modification
function Rotation:setAcceleration(r,g,b,a)
  local acc = self.store.acceleration
  acc.r = a or 0
  acc.r = r or 0
  acc.g = g or r
  acc.b = b or r
  return self:getAcceleration()
end

--- Gets the current acceleration.
-- @treturn int,int,int,int r,g,b,a components accelerations
function Rotation:getAcceleration()
  local acc = self.store.acceleration
  return acc.r,acc.g,acc.b,acc.a
end

return Color