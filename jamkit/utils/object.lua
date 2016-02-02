return function ()
  local object = {}
  local Object = {}
  Object.__index = Object
  Object.new = function(o,...) 
    local instance = setmetatable({}, o) 
    if instance.initialize then instance:initialize(...) end
    return instance
  end
  return Object
end

