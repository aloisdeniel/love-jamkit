local array = require("jamkit.utils.array")
local rectangles = require("jamkit.utils.rectangles")

local EntityCollection = class('EntitySet')

-- Entities are sorted in cells of the specified size from their bounds.
function EntityCollection:initialize(cellWidth,cellHeight)
  self.entities = {}
end

function EntityCollection:add(entity)
  assert(entity,"added entity is nil")
  table.insert(self.entities,entity)
  return entity
end

function EntityCollection:remove(entity)
  assert(entity,"removed entity is nil")
  array.unorderedRemove(self.entities,entity)
  return entity
end

function EntityCollection:getEntities(l,t,w,h, filter)
  if (not l) or (not t) or (not w) or (not h) then
    return self.entities
  end
  local result = {}
  for _,e in ipairs(self.entities) do
    local x,y,w,h = e:getBounds()
    if rectangles.intersect(x,y,w,h,l,t,w,h) and ((not filer) or filter(e)) then
      table.insert(result,e)
    end
  end
  return result
end

function EntityCollection:forEach(f)
  for _,e in ipairs(self.entities) do f(i,e) end
end

return EntityCollection