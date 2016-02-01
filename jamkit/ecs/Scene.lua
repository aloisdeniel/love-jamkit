local Scene = class('Scene')

function Scene:initialize(cellWidth,cellHeight)
  self.spawners = {}
end

function Scene:registerEntity(entityClass)
  self.spawners[entityClass.name] = entityClass
end

function Scene:spawn(entityClass,store)
  local name = entityClass.name or entityClass
  local entity = self.spawners[name]:new()
  return entity
end

function Scene:updateEntity(e)
  self:removeEntity(e)
end

function Scene:getEntities(l,t,w,h)
  
end

return Scene