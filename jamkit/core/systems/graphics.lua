local Parent = require("jamkit.ecs.System")
local Graphics = class("Graphics", Parent)

function Graphics:initialize(resources)
  self.resources = resources
end

function Graphics:drawEntities(entities)
  for _,entity in ipairs(entities) do
    if entity:isVisible then
      self:drawEntity(entity)
    end
  end
end

-- Resolve resource and draws entities to screen from the available entity components
function Graphics:drawEntity(entity)
  
  local x,y,angle,r,g,b,a,sx,sy = getAbsoluteValues(entity)
  
  if entity.components.sprite then
    local image, quad = entity.components.sprite:getImage()
    local _,_,w,h = quad:getViewport()
    x = x - (w/2) * sx
    y = y - (h/2) * sy
    love.graphics.setColor(r,g,b,a)
    love.graphics.draw(image, quad, x,y,angle,sx,sy)
  end
end

-- Gets all absolutes components values from parents hierarchy
local function getAbsoluteValues(entity)
  local x,y = (entity.components.position and entity.components.position:get()) or (0,0)
  local angle = (entity.components.rotation and entity.components.rotation:get()) or (0)
  local r,g,b,a = (entity.components.color and entity.components.color:get()) or (0)
  local sx,sy = (entity.components.scale and entity.components.scale:get()) or (1,1)
  
  if entity.components.attached then
    local parent = entity.components.attached:getParent()
    local px,py,pangle,pr,pg,pb,pa,psx,psy = getAbsoluteValues(parent)
    x,y = x+px,y+py
    angle = angle + pangle
    r,g,b,a = r*pr/255,g*pg/255,b*pb/255,a*pa/255
    sx,sy = sx*psx, sy*psy
  end
  
  return x,y,angle,r,g,b,a,sx,sy
end

return Graphics