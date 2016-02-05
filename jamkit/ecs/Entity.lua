--- Represents any object of the world. Components may be attached to it to add behaviors
-- (like a position, a renderer or a physics body).
-- @classmod Entity

local Component = require("jamkit.ecs.Component")

local Entity = class('Entity')
  
Entity.static.lastUid = 0
Entity.static.createUid = function() 
  Entity.static.lastUid = Entity.static.lastUid + 1
  return Entity.static.lastUid
end

function Entity:initialize()

  --- The unique generated identifier of the entity.
  self.uid = Entity.static.createUid() 
  
  --- Indicates whether the entity is visible.
  self.isVisible = true
  
  --- All added components are accessible 
  -- through this table. Note that their keys are the name of 
  -- their class with a lowercase first letter 
  -- (i.e. "Position" > "components.position")
  self.components = {} 
  
  --- Indicates the entity is destroyed and should be removed from the world.
  self.isDestroyed = false

end

--- Clones the entity. It creates an entity of the same class and clone each of its components.
-- @return The newly cloned entity.
function Entity:clone()
  local clone = self.class:new()
  -- Cloning all components
  for name,component in ipairs(self.components) do
    local componentClone = component:clone()
    clone:add(componentClone)
  end
  return clone
end

--- Extracts the entity state as a serializable table. All information for this 
-- entity to be restored is present in this table : uid, component stores, ...
-- @return A state table.
function Entity:serialize()
  if not self.isDestroyed then
    local result = {
      uid= self.uid,
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

--- Restores the state of an entity from a state table.
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

-- Components

--- Indicates whether this entity has a component of the given class.
-- @param component A component class
-- @return false if the entity hasn't any component of the given component type.
function Entity:has(component)
  return self:get(component)
end

--- Gets the entity with given component type.
-- @param component A component class
-- @return The component if owned, else nil
function Entity:get(component)
  local name = Component.toPropertyName(component)
  return self.components[name]
end

--- Adds the component to the entity. 
-- Note: an entity can only have one component of each type. 
-- @param component The component instance.
function Entity:add(component)
  local name = Component.toPropertyName(component)
  assert((not self.components[name]), "A " .. name .. " component has already been added to this entity")
  component:setEntity(self)
  self.components[name] = component
end

--- Removes the component to the entity.  
-- @param component The component instance, or type.
function Entity:remove(component)
  local name = Component.toPropertyName(component)
  assert(self.components[name] == component, "The given " .. name .. " component doesn't seem to be present")
  component:setEntity(nil)
  self.components[name] = nil
end

return Entity