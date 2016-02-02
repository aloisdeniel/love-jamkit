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
  
  local x,y = entity:getAbsolutePosition()
  local sx,sy = entity:getAbsoluteScale()
  local ox,oy = entity.components.origin.x,entity.components.origin.y
  local r = entity:getAbsoluteRotation()
  local cr,cg,cb,ca = entity:getAbsoluteColor()
  
  if entity.components.image then
    local image = self.resources:image(entity.components.image)
    love.graphics.setColor(cr,cg,cb,ca)
    if entity.components.animation then    
      local animation = self.resources.animations[entity.components.animation]
      local w,h = animation:getDimensions()
      x = x - (w/2) * sx
      y = y - (h/2) * sy
      animation:draw(image, x,y, r, sx, sy, ox, oy)
    elseif entity.components.quad then
      local quad = self.assets.quads[entity.components.quad]
      local _,_,w,h = quad:getViewport()
      x = x - (w/2) * sx
      y = y - (h/2) * sy
      love.graphics.draw(image, quad, x,y,r,sx,sy,ox,oy)
    else
      local w,h = image:getDimensions()
      x = x - (w/2) * sx
      y = y - (h/2) * sy
      love.graphics.draw(image, quad, x,y,r,sx,sy,ox,oy)
    end
  elseif entity.components.text
    local text = self.assets.texts[entity.components.text]
    local w,h = text:getWidth(), text:getHeight()
    x = x - (w/2) * sx
    y = y - (h/2) * sy
    love.graphics.draw(text, x,y,r,sx,sy,ox,oy)
  elseif entity.components.rectangle
    local rect = entity.components.rectangle
    love.graphics.draw(rect.mode or "fill",rect.x,rect.y,rect.w,rect.h)
  end
end

return Graphics