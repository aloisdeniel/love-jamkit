local resources = {
  isLoaded = false,
  resources = {},
  loaded = {},
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

function resources.register(rtype, id, value)
  local r = resources.loaders[rtype]
  assert(r,"The resource type can't be loaded")
  if not resources.resources[rtype] then resources.resources[rtype] = {} end
  assert(not r[id],"A resource with the " .. id .. " has already been registered")
  r[id] = value
end

function resources.load()
  for rtype, resources in ipairs(resources.resources) do
    local loader = resources.loaders[rtype]
    if not resources.loaded[rtype] then resources.loaded[rtype] = {} end
    local loaded = resources.loaded[rtype]
    for id,res in ipairs(resources) do
      loaded[id] = loader(res)
    end
  end
  resources.isLoaded = true
end

function resources.get(rtype, id)
  assert(resources.isLoaded,"The resources had not been loaded yet")
  local r = resources.loaded[rtype]
  assert(r,"The resource type can't be loaded")
  local res = r[id]
  assert(res,"The ".. rtype .." resource with " .. id .. " cannot be found")
  return res
end

function resources.data(id) return resources.:get("data",id) end
function resources.text(id) return resources.:get("text",id) end
function resources.image(id) return resources.:get("image",id) end
function resources.font(id) return resources.:get("font",id) end
function resources.quad(id) return resources.:get("quad",id) end
function resources.shader(id) return resources.:get("shader",id) end
function resources.sound(id) return resources.:get("sound",id) end
function resources.music(id) return resources.:get("music",id) end

return resources