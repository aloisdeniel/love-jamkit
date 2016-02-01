local Parent = require("jamkit.ecs.Component")
local Sprite = class('Sprite',Parent)

function Position:initialize(image)
  Parent.initialize(self)
  assert(type(image) == "string", "The image must be the id of the the resource and not the image object")
  assert(type(quad) == "string", "The quad must be the id of the the resource and not the image object")
  self.store.image = image
  self.store.quad = quad
  self.store.offset = { x= 0, y=0 }
end

return Position