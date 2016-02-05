--- A component that renders an image, or part on image on screen.
--
--### Extends : @{Component} > @{Renderer}
-- @classmod Sprite

local Parent = require("jamkit.components.renderers.Renderer")
local Sprite = class('Sprite',Parent)

function Sprite:initialize()
  Parent.initialize(self)
  self.store.imageId = nil
  self.store.quadId = nil
  self.image = nil
  self.quad = nil
end

--- Sets the image and quad resource identifiers.
-- @string imageId The resource identifier of the image
-- @string[opt] quadId The resource identifier of the quad (full image if not precised)
function Sprite:setImageId(imageId,quadId)
  self.store.imageId = imageId
  self.store.quadId = quadId
end

--- Gets the image and quad resource identifiers.
-- @treturn string,string The imageId,quadId from the resources.
function Sprite:getImageId()
  return self.store.imageId, self.store.quadId
end

--- Sets the loaded image and quad data.
-- Warning : this method is normaly used only par @{Resource} system.
-- @tparam Image image The image data
-- @tparam[opt] Quad quad The quad data (full image if not precised)
-- @treturn Image,Quad The image,quad data
function Sprite:setImage(image,quad)
  self.image = image
  self.quad = quad, quad
  return image
end

--- Gets the loaded image and data.
-- @treturn Image,Quad The image,quad data
function Sprite:getImage()
  return self.image, self.quad
end

return Sprite