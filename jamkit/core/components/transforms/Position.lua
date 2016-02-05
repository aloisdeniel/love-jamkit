--- A component that represents the current position of an entity.
--
--### Extends : @{Component}
-- @classmod Position

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

--- @section Value

--- Sets the current position coordinates.
-- @number x The x coordinate
-- @number y The y coordinate
-- @treturn number,number The position coordinates after modification
function Position:set(x,y)
  self.store.x, self.store.y = x,y
  return self:get()
end

--- Gets the current position coordinates.
-- @treturn number,number The x,y coordinates
function Position:get()
  return self.store.x, self.store.y
end

--- Adds values to current position coordinates.
-- @number x The value to add to x current coordinate
-- @number y The value to add to y current coordinate
-- @number[opt] delta *(optional)* A factor applied to added x and y values
-- @treturn number,number The position coordinates after modification
function Position:add(x,y,delta)
  delta = delta or 1
  local cx,cy = self:get()
  self:set(cx+(x*delta),cy+(y*delta))
  return self:get()
end

--- @section Velocity

--- Sets the current velocity.
-- @number x The x coordinate velocity
-- @number y The y coordinate velocity
-- @treturn number,number The velocity after modification
function Position:setVelocity(x,y)
  self.store.velocity.x, self.store.velocity.y = x,y
  return self:getVelocity()
end

--- Gets the current velocity.
-- @treturn number,number The x,y coordinate velocities
function Position:getVelocity()
  return self.store.velocity.x, self.store.velocity.y
end

--- Adds values to current coordinates velocity.
-- @number x The value to add to x current velocity
-- @number y The value to add to y current velocity
-- @number[opt] delta *(optional)* A factor applied to added x and y values
-- @treturn number,number The velocity after modification
function Position:addVelocity(x,y,delta)
  delta = delta or 1
  local cx,cy = self:getVelocity()
  self:setVelocity(cx+(x*delta),cy+(y*delta))
  return self:getVelocity()
end

-- Acceleration

--- Sets the current acceleration.
-- @number x The x coordinate acceleration
-- @number y The y coordinate acceleration
-- @treturn number,number The acceleration after modification
function Position:setAcceleration(x,y)
  self.store.acceleration.x, self.store.acceleration.y = x,y
  return self:getAcceleration()
end

--- Gets the current acceleration.
-- @treturn number,number The x,y coordinate accelerations
function Position:getAcceleration()
  return self.store.acceleration.x, self.store.acceleration.y
end

--- Adds values to current coordinates acceleration.
-- @number x The value to add to x current acceleration
-- @number y The value to add to y current acceleration
-- @number[opt] delta *(optional)* A factor applied to added x and y values
-- @treturn number,number The acceleration after modification
function Position:addAcceleration(x,y,delta)
  delta = delta or 1
  local cx,cy = self:getAcceleration()
  self:setAcceleration(cx+(x*delta),cy+(y*delta))
  return self:getAcceleration()
end

return Position