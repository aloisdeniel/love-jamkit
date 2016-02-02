local Inputs = require("jamkit.utils.object")()

Inputs.STATE = {
  STARTED = "started",
  PRESSED = "pressed",
  RELEASED = "released",
}

function Inputs:initialize()
  self.commands = {}
  self.actions = {}
end

function Inputs:register(name, keyboard, touch)
  
  if keyboard then
    if not self.commands.keyboard then 
      self.commands.keyboard = {} 
    else
      assert(not self.commands.keyboard[name], "A keyboard command with the id " .. name .. " has already been registered")
    end
    self.commands.keyboard[name] = keyboard
  end
  
  if touch then
    if not self.commands.touch then 
      self.commands.touch = {} 
    else
      assert(not self.commands.touch[name], "A touch command with the id " .. name .. " has already been registered")
    end
    inputs.commands.touch[name] = touch
  end
  
end

function Inputs:isPressed(name)
  local action = self.actions[name]
  return action and ((action == Inputs.STATE.STARTED) or (action == Inputs.STATE.PRESSED))
end

function Inputs:isStarted(name)
  local action = self.actions[name]
  return action and (action == Inputs.STATE.STARTED)
end

function Inputs:isReleased(name)
  local action = self.actions[name]
  return action and (action == Inputs.STATE.RELEASED)
end

function Inputs:update(dt)
    local actions = {}
    
    -- Keyboard
    if self.commands.keyboard then
      local controllerActions = self:getKeyboard()
      for name,isPressed in pairs(controllerActions) do
        if isPressed then actions[name] = true end
      end
    end
    
    -- Touch
    if self.commands.touch then
      local controllerActions = self:getTouch()
      for name,isPressed in pairs(controllerActions) do
        if isPressed then actions[name] = true end
      end
    end
    
    -- Updating start or pressed
    for name,action in pairs(actions) do
      if (self.actions[name] == Inputs.STATE.STARTED) or (self.actions[name] == Inputs.STATE.PRESSED ) then 
        actions[name] = Inputs.STATE.PRESSED 
      else 
        actions[name] = Inputs.STATE.STARTED
      end
    end
    
    -- Added released buttons
    for name, oldAction in pairs(self.actions) do
      if (not actions[name]) and (not (oldAction == Inputs.STATE.RELEASED )) then
        actions[name] = Inputs.STATE.RELEASED 
      end
    end
        
    self.actions = actions
    
    return actions
end

-- Controller : keyboard

function Inputs:getKeyboard()
  local actions = {}
  -- Updating touched buttons
  for name,button in pairs(self.commands.keyboard) do
    for _,key in ipairs(button) do
      if love.keyboard.isDown(key) then
        actions[name] = true
      end 
    end
  end
  
  return actions
end

-- Controller : touch

local function isTouchPressed(x,y,b)
  return (x > b.x) and (x < b.x + b.w) and (y > b.y) and (y < b.y + b.h)
end

function Inputs:getTouch()
  local actions = {}
  local touches = love.touch.getTouches()
  
  -- Updating pressed buttons
  for _,id in pairs(touches) do
    local x, y = love.touch.getPosition(id)
    for name,button in pairs(self.commands.touch) do
      if isTouchPressed(x,y,button) then actions[name] = true end 
    end
  end 
  
  -- Back button
  if love.keyboard.isDown("escape") then
    actions["menu"] = true
  end

  return actions
end

return Inputs