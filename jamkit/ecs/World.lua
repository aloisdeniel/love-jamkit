local World = class('World')

function World:initialize()
  Parent.initialize(self)
  self.systems = {}
end

function World:addSystem(s)
  table.insert(self.systems,s)
end

function EntityCollection:registerEntity(name,spawner)
  self.spawners[name] = spawner
end

function EntityCollection:spawn(entityClass)
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

function World:update(dt)
  for _,s in ipairs(self.systems) do
    s:update(dt)
  end
end

function World:draw(l,t,w,h)
  for _,s in ipairs(self.systems) do
    s:draw(l,t,w,h)
  end
end

return World