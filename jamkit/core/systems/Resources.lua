--- A system that manages resources of all entities. It preloads all its resources and affects it to 
-- created entities.
-- @classmod Resources

local Parent = require("jamkit.ecs.System")
local Resources = class("Resources", Parent)

Resources.loaders = {
  data = function(value) return love.filesystem.load(value)() end,
  text = function(value) return love.filesystem.read(value) end,
  image = function(value) return love.graphics.newImage(value) end, -- Todo load atlas
  shader = function(value) return love.graphics.newShader(value) end,
  font = function(value) return love.graphics.newFont(value[1], value[2]) end,
  sound = function(value) return love.audio.newSource(value, "static") end,
  music = function(value) return love.audio.newSource(value, "stream") end,
}

function Resources:initialize()
  Parent.initialize(self)
  self.isLoaded = false
  self.resources = {}
  self.loaded = {}
end

function Resources:load()
  Parent.load(self)
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

-- @section Registering resources

function Resources:_register(rtype, id, value)
  local r = .loaders[rtype]
  assert(r,"The resource type can't be loaded")
  if not self.resources[rtype] then self.resources[rtype] = {} end
  assert(not r[id],"A resource with the " .. id .. " has already been registered")
  r[id] = value
end

function Resources:_registerAll(rtype, values)
  for id,v in ipairs(values) do
    self:register(rtype,id,v)
  end
end

--- Registering a lua table.
-- @param id The identifier of the resource
-- @param path The file path to the loaded resource.
function Resources:registerData(id, path)
  self:_register("data", path)
end

--- Registering a text.
-- @param id The identifier of the resource
-- @param path The file path to the loaded resource.
function Resources:registerText(id, path)
  self:_register("text", path)
end

--- Registering an image.
-- @param id The identifier of the resource
-- @param path The file path to the loaded resource.
function Resources:registerImage(id, path)
  self:_register("image", path)
end

--- Registering an font.
-- @param id The identifier of the resource
-- @param path The file path to the loaded resource
-- @param size The size of the font
function Resources:registerFont(id, path, size)
  self:_register("font", { path, (size or 10) })
end

--- Registering an shader.
-- @param id The identifier of the resource
-- @param path The file path to the loaded resource.
function Resources:registerShader(id, path)
  self:_register("shader", path)
end

--- Registering a sound.
-- @param id The identifier of the resource
-- @param path The file path to the loaded resource.
function Resources:registerSound(id, path)
  self:_register("sound", path)
end

--- Registering a music.
-- @param id The identifier of the resource
-- @param path The file path to the loaded resource.
function Resources:registerMusic(id, path)
  self:_register("sound", path)
end

-- @section Registering resource sets

--- Registering multiple lua tables at once.
-- @param data A table with id as key, and path as value of each entry
function Resources:registerPiecesOfData(data)
  self:_registerAll("data", data)
end

--- Registering multiple texts at once.
-- @param data A texts with id as key, and path as value of each entry
function Resources:registerTexts(texts)
  self:_registerAll("text", texts)
end

--- Registering multiple images at once.
-- @param images A table with id as key, and path as value of each entry
function Resources:registerImages(images)
  self:_registerAll("image", images)
end

--- Registering multiple fonts at once.
-- @param data A table with id as key, and a table with path and size entries.
function Resources:registerFonts(fonts)
  local values = {}
  for id, v in ipairs(fonts) do values[id] = {v.path, v.size} end
  self:_registerAll("font", values)
end

--- Registering multiple shaders at once.
-- @param shaders A table with id as key, and path as value of each entry
function Resources:registerShaders(shaders)
  self:_registerAll("shader", shaders)
end

--- Registering multiple sounds at once.
-- @param sounds A table with id as key, and path as value of each entry
function Resources:registerSounds(sounds)
  self:_registerAll("sound", sounds)
end

--- Registering multiple musics at once.
-- @param musics A table with id as key, and path as value of each entry
function Resources:registerMusics(musics)
  self:_registerAll("music", musics)
end

-- @section Accessing resources

function Resources:_get(rtype, id)
  assert(self.isLoaded,"The resources has not been loaded yet")
  local r = self.loaded[rtype]
  assert(r,"The resource type can't be loaded")
  local res = r[id]
  assert(res,"The ".. rtype .." resource with " .. id .. " cannot be found")
  return res
end

--- Gets a lua table.
-- @param id The identifier of the resource
-- @return A lua table
function Resources:data(id) return self:_get("data",id) end

--- Gets a text content.
-- @param id The identifier of the resource
-- @return A string with the requested text.
function Resources:text(id) return self:_get("text",id) end

--- Gets an image.
-- @param id The identifier of the resource
-- @return The image and its quad atlas if available
function Resources:image(id) return self:_get("image",id) end

--- Gets a font.
-- @param id The identifier of the resource
-- @return The font object.
function Resources:font(id) return self:_get("font",id) end

--- Gets a shader.
-- @param id The identifier of the resource
-- @return The shader object.
function Resources:shader(id) return self:_get("shader",id) end

--- Gets a sound (static source).
-- @param id The identifier of the resource
-- @return The source object.
function Resources:sound(id) return self:_get("sound",id) end

--- Gets a music (stream source).
-- @param id The identifier of the resource
-- @return The source object.
function Resources:music(id) return self:_get("music",id) end

return Resources