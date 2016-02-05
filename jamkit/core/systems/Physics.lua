local bump = require('lib.bump')
local Body = require('jamkit.core.components.Body')

local Parent = require("jamkit.ecs.System")
local Physics = class("Inputs", Parent)

function Physics:initialize(worldCellSize)
  Parent.initialize(self)
  self.world = bump.newWorld(worldCellSize or 64)
end

function System:isEntitySupported(e)
  return e:hasComponent(Body)
end

function System:addEntity(e)
  Parent.addEntity(e)
  local w,h = e.components.body:getDimensions()
  self.world:add(component, x, y, w,h)
end

function System:removeEntity(e)
  Parent.removeEntity(e)
end

function System:updateEntity(e,dt)
  
end

function Physics:updateTransform(entity,dt)
  
  if entity.components
  
  local current, velocity, acceleration = transform.position.current, transform.position.velocity, transform.position.acceleration
  velocity.value.x = velocity.value.x + acceleration.x * dt
  velocity.value.y = velocity.value.y + acceleration.y * dt
  if velocity.max.x then current.x = math.min(velocity.max.x, velocity.value.x) end
  if velocity.max.y then current.y = math.min(velocity.max.y, velocity.value.y) end
  if velocity.min.x then current.x = math.max(velocity.min.x, velocity.value.x) end
  if velocity.min.y then current.y = math.max(velocity.min.y, velocity.value.y) end
  current.x = current.x + dt * velocity.value.x
  current.y = current.y + dt * velocity.value.y
  acceleration.x = 0
  acceleration.y = 0
  
end

return physics