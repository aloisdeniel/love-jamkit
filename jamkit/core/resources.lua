local Resources = require("jamkit.utils.object")()

Resources.loaders = {
  data = function(value) return love.filesystem.load(value)() end,
  text = function(value) return love.filesystem.read(value) end,
  image = function(value) return love.graphics.newImage(value) end,
  shader = function(value) return love.graphics.newShader(value) end,
  font = function(value) return love.graphics.newFont(value[1], value[2]) end,
  quads = function(value) return love.filesystem.load(value)() end,
  sound = function(value) return love.audio.newSource(value, "static") end,
  music = function(value) return love.audio.newSource(value, "stream") end,
}

function Resources:initialize()
  self.isLoaded = false
  self.resources = {}
  self.loaded = {}
end

function Resources:register(rtype, id, value)
  local r = .loaders[rtype]
  assert(r,"The resource type can't be loaded")
  if not self.resources[rtype] then self.resources[rtype] = {} end
  assert(not r[id],"A resource with the " .. id .. " has already been registered")
  r[id] = value
end

function Resources:load()
  for rtype, typeResources in ipairs(self.resources) do
    local loader = .loaders[rtype]
    if not self.loaded[rtype] then self.loaded[rtype] = {} end
    local loaded = self.loaded[rtype]
    for id,res in ipairs(typeResources) do
      loaded[id] = loader(res)
    end
  end
  self.isLoaded = true
end

function Resources:get(rtype, id)
  assert(self.isLoaded,"The resources has not been loaded yet")
  local r = self.loaded[rtype]
  assert(r,"The resource type can't be loaded")
  local res = r[id]
  assert(res,"The ".. rtype .." resource with " .. id .. " cannot be found")
  return res
end

-- Helper accessors
function Resources:data(id) return self:get("data",id) end
function Resources:text(id) return self:get("text",id) end
function Resources:image(id) return self:get("image",id) end
function Resources:font(id) return self:get("font",id) end
function Resources:quad(id) return self:get("quad",id) end
function Resources:shader(id) return self:get("shader",id) end
function Resources:sound(id) return self:get("sound",id) end
function Resources:music(id) return self:get("music",id) end

return Resources