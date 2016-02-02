-- Global requires (discouraged but much more simplier for this frequently used modules)

inspect =  require("jamkit.lib.inspect")
class = require("jamkit.lib.middleclass")
stateful = require("jamkit.lib.stateful")
vector = require("jamkit.lib.vector")

-- Global

local instance 

jamkit = {
  _VERSION     = 'jamkit 0.1.0',
  _DESCRIPTION = 'simple game engine on top of LÖVE, thought for game jams. ',
  _URL         = 'https://github.com/aloisdeniel/love-jamkit.lua',
  _LICENSE     = [[
    MIT LICENSE
    Copyright (c) 2016 Alois Deniel
    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  ]],
  init = init
  update = update
}

local defaultOpts = {
  assets = "assets",
  commands = {
    touch = {
      right={ x=10,y=10,w=20,h=20 }, 
      left={ x=10,y=10,w=20,h=20 }, 
      top={ x=10,y=10,w=20,h=20 }, 
      down={ x=10,y=10,w=20,h=20 }, 
      action1={ x=10,y=10,w=20,h=20 }, 
      action2={ x=10,y=10,w=20,h=20 }, 
      escape={ x=10,y=10,w=20,h=20 }, 
    },
    keyboard = { 
      right={ "right" }, 
      left={ "left" }, 
      top={ "top" }, 
      down={ "down" }, 
      action1={ "space" },
      action2={ "leftctrl" },
      escape={ "escape" },
    }
  }
}

local function init(opts)
  assert(not instance), "Already initialized"
  
  -- Options
  local assets = opts.assets or defaultOpts.assets
  local commands = opts.commands or defaultOpts.commands

  -- Creating systems
  jamkit.resources = require("jamkit.core.Resources"):new()
  jamkit.graphics = require("jamkit.core.Graphics"):new(jamkit.resources)
  jamkit.physics = require("jamkit.core.Physics"):new()
  jamkit.inputs = require("jamkit.core.Inputs"):new()
end

local function update(dt)
  jamkit.inputs:update(dt)
end

function love.load()
  if jamkit.load then
    jamkit.load()
  end
  jamkit.resources.load()
end
