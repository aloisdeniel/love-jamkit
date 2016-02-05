--- A component can be attached to an entity to add functionalities to
-- an entity. It can also be serialized through its store, and restored.
-- All components are updated through systems.
-- @classmod Component

local Component = class('Component')

Component.static.toPropertyName = function(component)
  if type(component) ~= 'string' then 
    if component.class then
      component = component.class.name
    else
      component = component.name
    end
  end
  
  return component:gsub("^%u", string.lower)
end

local function copyStore(store)
  if type(store) ~= 'table' then return store end
  local res = {}
  for k, v in pairs(store) do res[copyStore(k)] = copyStore(v) end
  return res
end

function Component:clone()
  local clone = self.class:new()
  clone.store = copyStore(self.store)
  return clone
end

function Component:initialize()
  self.entity = nil
  self.store = {}
end

function Component:getEntity()
  return self.entity
end

function Component:setEntity(e)
  if e then
    assert((not self.entity), "The component has already been added to an other entity")
    self.entity = e
    self:added(e)
  elseif self.entity then
    e = self.entity
    self.entity = nil
    self:removed(e)
  end
end

function Component:added(e)
  
end

function Component:removed(e)
  
end

return Component