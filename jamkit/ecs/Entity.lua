local Component = require("jamkit.ecs.Component")

local Entity = class('Entity')

function Entity:initialize()
  self.order = 0
  self.parent = nil
  self.isVisible = true
  self.isDestroyed = false
  self.scripts = {}
  self.components = {}
end

-- Parent entity

function Entity:attach(parent)
  assert((not self.parent),"entity is already attached to an other entity")
  self.parent = parent
end

function Entity:dettach(parent)
  assert(self.parent and (self.parent == parent),"entity isn't attached to the given one")
  self.parent = nil
end

function Entity:getParent()
  return self.parent
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