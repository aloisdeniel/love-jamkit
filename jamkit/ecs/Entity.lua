local Component = require("jamkit.ecs.Component")

local Entity = class('Entity')

Entity.static.lastUid = 0
Entity.static.createUid = function() 
  Entity.static.lastUid = Entity.static.lastUid + 1
  return Entity.static.lastUid
end

function Entity:initialize()
  self.uid = Entity.static.createUid()
  self.parent = nil
  self.isVisible = true
  self.isDestroyed = false
  self.scripts = {}
  self.components = {}
end

function Entity:clone()
  local clone = self.class:new()
  -- Cloning all components
  for name,component in ipairs(self.components) do
    local componentClone = component:clone()
    clone:add(componentClone)
  end
  return clone
end

-- Serialization (all components)

function Entity:serialize()
  if not self.isDestroyed then
    local result = {
      uid= self.uid,
      layer = self.layer,
      components = {}
    }
    for name, component in pairs(self.components) do
      result.components[name] = component.store
    end
    for name, script in pairs(self.scripts) do
      result.script[name] = component.store
    end
  end
end

function Entity:deserialize(data)
  if data.uid then
    self.uid = data.uid
    Entity.static.lastUid = math.max(Entity.static.lastUid,data.uid) -- Updating uid counter
  end
  self.layer = data.layer
  for name, store in pairs(data.components) do
    self.components[name].store = store
  end
end

-- Scripts

function Entity:addScript(script)
  assert((not script.entity),"script is already attached to an entity")
  script.entity = self
  self.scripts[script] = true
  script:onAttached()
end

function Entity:removedScript(script)
  assert(self.scripts[script],"script isn't attached to this entity")
  self.scripts[script] = nil
  script.entity = nil
  script:onDettached()
end

-- Components

function Entity:has(component)
  return self:get(component)
end

function Entity:get(component)
  local name = Component.toPropertyName(component)
  return self.components[name]
end

function Entity:add(component)
  local name = Component.toPropertyName(component)
  assert((not self.components[name]), "A " .. name .. " component has already been added to this entity")
  component:setEntity(self)
  self.components[name] = component
end

function Entity:remove(component)
  local name = Component.toPropertyName(component)
  assert(self.components[name] == component, "The given " .. name .. " component doesn't seem to be present")
  component:setEntity(nil)
  self.components[name] = nil
end

return Entity