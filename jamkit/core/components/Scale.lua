local Parent = require("jamkit.ecs.Component")
local Position = class('Scale',Parent)

function Scale:initialize()
  Parent.initialize(self)
end


function Scale:_getParentValue()
  local entity = self.getEntity()
  if entity then
    local parent = entity.getParent()
    if parent and parent.components.size then
      return parent.components.size:get()
    end
  end
  return 1
end

function Scale:setAbsolute(x,y)
  local px,py = self:_getParentValue()
  self:set(x / px, y / py)
end

function Scale:getAbsolute()
  local x,y = self:get()
  local px,py = self:_getParentValue()
  return x * px, y * py
end

return Scale