local Parent = require('jamkit.ecs.Component')
local Script = class('Script',Parent)

function Script:initialize()
  Parent.initialize(self)
end

function Script:onAttached()

end

function Script:update(dt)

end

function Script:onDettached()

end

return Script