local Parent = require("jamkit.ecs.Component")
local Renderer = class('Renderer',Parent)

function Renderer:initialize(image)
  Parent.initialize(self)
  self.order = 0
end

return Renderer