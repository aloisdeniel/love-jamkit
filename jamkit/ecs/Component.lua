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
  else
    self.entity = nil
  end
end

return Component