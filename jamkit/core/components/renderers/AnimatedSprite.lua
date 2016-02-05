--- A component that renders an animated quad
--
--### Extends : @{Component} > @{Renderer} > @{Sprite}
-- @classmod AnimatedSprite

local Parent = require("jamkit.components.renderers.Sprite")
local AnimatedSprite = class('AnimatedSprite',Parent)

function AnimatedSprite:initialize()
  Parent.initialize(self)
  self.store.animations = {} -- List of quad ids
  self.animations = {} -- Loaded quads
end

return AnimatedSprite