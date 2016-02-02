local Parent = require("jamkit.ecs.System")
local Physics = class("Inputs", Parent)

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