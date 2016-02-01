local resources = {
  loaders = {
    data = function(value) return love.filesystem.load(value)() end,
    text = function(value) return love.filesystem.read(value) end,
    image = function(value) return love.graphics.newImage(value) end,
    shader = function(value) return love.graphics.newShader(value) end,
    font = function(value) return love.graphics.newFont(value[1], value[2]) end,
    quads = function(value) return love.filesystem.load(value)() end,
    sound = function(value) return love.audio.newSource(value, "static") end,
    music = function(value) return love.audio.newSource(value, "stream") end,
  }
}

local Resources = {}
local ResourcesMt = {__index = Resources}

resources.new = function(resources)
  return setmetatable({
    isLoaded = false,
    resources = {},
    loaded = {},
  },ResourcesMt)
end

function Resources:register(rtype, id, value)
  local r = resources.loaders[rtype]
  assert(r,"The resource type can't be loaded")
  if not resources.resources[rtype] then resources.resources[rtype] = {} end
  assert(not r[id],"A resource with the " .. id .. " has already been registered")
  r[id] = value
end

function resources.load()
  for rtype, resources in ipairs(self.resources) do
    local loader = resources.loaders[rtype]
    if not resources.loaded[rtype] then resources.loaded[rtype] = {} end
    local loaded = resources.loaded[rtype]
    for id,res in ipairs(resources) do
      loaded[id] = loader(res)
    end
  end
  self.isLoaded = true
end

function resources:get(rtype, id)
  assert(self.isLoaded,"The resources had not been loaded yet")
  local r = self.loaded[rtype]
  assert(r,"The resource type can't be loaded")
  local res = r[id]
  assert(res,"The ".. rtype .." resource with " .. id .. " cannot be found")
  return res
end

function resources:data(id) return self:get("data",id) end
function resources:text(id) return self:get("text",id) end
function resources:image(id) return self:get("image",id) end
function resources:font(id) return self:get("font",id) end
function resources:quad(id) return self:get("quad",id) end
function resources:shader(id) return self:get("shader",id) end
function resources:sound(id) return self:get("sound",id) end
function resources:music(id) return self:get("music",id) end

return resources