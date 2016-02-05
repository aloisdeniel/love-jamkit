--- A component that represents the rotation of an entity.
--
--### Extends : @{Component}
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

--- @section Value

--- Sets the current angle.
-- @number a The angle
-- @treturn number The angle after modification
function Rotation:set(a)
  self.store.angle = a
  return self:get()
end

--- Gets the current angle.
-- @treturn number The angle value.
function Rotation:get()
  return self.store.angle
end

--- Adds values to current position coordinates.
-- @number a The value to add to current angle 
-- @number delta *(optional)* A factor applied to added angle value
-- @treturn number The angle after modification
function Rotation:add(a,delta)
  delta = delta or 1
  local ca = self:get()
  self:set(ca+(a*delta))
  return self:get()
end

--- @section Velocity

--- Sets the current angular velocity.
-- @number a The angular velocity
-- @treturn number The angular velocity after modification
function Rotation:setVelocity(a)
  self.store.velocity = a
  return self:getVelocity()
end

--- Gets the current angular velocity.
-- @treturn number Then angle velocity
function Rotation:getVelocity()
  return self.store.velocity
end 

--- @section Acceleration

--- Sets the current angular acceleration.
-- @number a The angular acceleration
-- @treturn number The angular acceleration after modification
function Rotation:setAcceleration(a)
  self.store.acceleration = a
  return self:getAcceleration()
end

--- Gets the current angular acceleration.
-- @treturn number Then angle acceleration
function Rotation:getAcceleration()
  return self.store.acceleration
end

return Rotation