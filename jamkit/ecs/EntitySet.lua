local array = require("jamkit.utils.array")
local rectangles = require("jamkit.utils.rectangles")

local EntitySet = class('EntitySet')

-- Entities are sorted in cells of the specified size from their bounds.
function EntitySet:initialize(cellWidth,cellHeight)
  self.spawners = {}
  self.entities = {}
end


function EntitySet:registerEntity(name,spawner)
  self.spawners[name] = spawner
end

function EntitySet:spawn(entityClass)
  local name = entityClass.name or entityClass
  local spawner = self.spawners[name];
  local entity = nil
  if type(spawner) == 'function' then
    entity = spawner()
  else
    entity = spawner:new()
  else
  self:addEntity(entity)
  return entity
end

function EntitySet:addEntity(entity)
  assert(entity,"added entity is nil")
  table.insert(self.entities,entity)
  return entity
end

function EntitySet:removeEntity(entity)
  assert(entity,"removed entity is nil")
  array.unorderedRemove(self.entities,entity)
  return entity
end

function EntitySet:getEntities(l,t,w,h)
  if (not l) or (not t) or (not w) or (not h) then
    return self.entities
  end
  local result = {}
  for _,e in ipairs(self.entities) do
    local x,y,w,h = e:getBounds()
    if rectangles.intersect(x,y,w,h,l,t,w,h) then
      table.insert(result,e)
    end
  end
  return result
end

return EntitySet