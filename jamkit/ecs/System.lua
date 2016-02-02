local EntityCollection = require("jamkit.ecs.EntityCollection")
local System = class('System')

function System:initialize()
  Parent.initialize(self)
  self.entities = EntityCollection:new()
end

function System:isEntitySupported(e)
  return true
end

function System:addEntity(e)
  if self:isEntitySupported(e) then
    self.entities:add(e)
  end
end

function System:removeEntity(e)
  self.entities:remove(e)
end

function System:update(dt)

end

return System