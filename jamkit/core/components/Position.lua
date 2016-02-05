--- A component that represents the current position of an entity.
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
-- @return The position coordinates after modification
function Position:set(x,y)
  self.store.x, self.store.y = x,y
  return self:get()
end

--- Gets the current position coordinates.
-- @return x,y coordinates
function Position:get()
  return self.store.x, self.store.y
end

--- Adds values to current position coordinates.
-- @param x The value to add to x current coordinate
-- @param y The value to add to y current coordinate
-- @param delta *(optional)* A factor applied to added x and y values
-- @return The position coordinates after modification
function Position:add(x,y,delta)
  delta = delta or 1
  local cx,cy = self:get()
  self:set(cx+(x*delta),cy+(y*delta))
  return self:get()
end

--- @section Velocity

--- Sets the current velocity.
-- @param x The x coordinate velocity
-- @param y The y coordinate velocity
-- @return The velocity after modification
function Position:setVelocity(x,y)
  self.store.velocity.x, self.store.velocity.y = x,y
  return self:getVelocity()
end

--- Gets the current velocity.
-- @return x,y coordinate velocities
function Position:getVelocity()
  return self.store.velocity.x, self.store.velocity.y
end

--- Adds values to current coordinates velocity.
-- @param x The value to add to x current velocity
-- @param y The value to add to y current velocity
-- @param delta *(optional)* A factor applied to added x and y values
-- @return The velocity after modification
function Position:addVelocity(x,y,delta)
  delta = delta or 1
  local cx,cy = self:getVelocity()
  self:setVelocity(cx+(x*delta),cy+(y*delta))
  return self:getVelocity()
end

-- Acceleration

--- Sets the current acceleration.
-- @param x The x coordinate acceleration
-- @param y The y coordinate acceleration
-- @return The acceleration after modification
function Position:setAcceleration(x,y)
  self.store.acceleration.x, self.store.acceleration.y = x,y
  return self:getAcceleration()
end

--- Gets the current acceleration.
-- @return x,y coordinate accelerations
function Position:getAcceleration()
  return self.store.acceleration.x, self.store.acceleration.y
end

--- Adds values to current coordinates acceleration.
-- @param x The value to add to x current acceleration
-- @param y The value to add to y current acceleration
-- @param delta *(optional)* A factor applied to added x and y values
-- @return The acceleration after modification
function Position:addAcceleration(x,y,delta)
  delta = delta or 1
  local cx,cy = self:getAcceleration()
  self:setAcceleration(cx+(x*delta),cy+(y*delta))
  return self:getAcceleration()
end

--[[ --Should be in systems
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

]]

return Position