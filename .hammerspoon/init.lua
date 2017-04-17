local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(100)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:disable()
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      if name ~= "iTerm2" then
         enableAllHotkeys()
      else
         disableAllHotkeys()
      end
   end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))

remapKey({'ctrl', 'shift'}, 'f', keyCode('right', {'shift'}))
remapKey({'ctrl', 'shift'}, 'b', keyCode('left', {'shift'}))
remapKey({'ctrl', 'shift'}, 'n', keyCode('down', {'shift'}))
remapKey({'ctrl', 'shift'}, 'p', keyCode('up', {'shift'}))

remapKey({'ctrl', 'cmd'}, 'f', keyCode('right', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'b', keyCode('left', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'n', keyCode('down', {'cmd'}))
remapKey({'ctrl', 'cmd'}, 'p', keyCode('up', {'cmd'}))

remapKey({'ctrl', 'alt'}, 'f', keyCode('right', {'alt'}))
remapKey({'ctrl', 'alt'}, 'b', keyCode('left', {'alt'}))
remapKey({'ctrl', 'alt'}, 'n', keyCode('down', {'alt'}))
remapKey({'ctrl', 'alt'}, 'p', keyCode('up', {'alt'}))

remapKey({'ctrl', 'shift', 'cmd'}, 'f', keyCode('right', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'b', keyCode('left', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'n', keyCode('down', {'shift', 'cmd'}))
remapKey({'ctrl', 'shift', 'cmd'}, 'p', keyCode('up', {'shift', 'cmd'}))

remapKey({'ctrl', 'alt', 'cmd'}, 'f', keyCode('right', {'alt', 'cmd'}))
remapKey({'ctrl', 'alt', 'cmd'}, 'b', keyCode('left', {'alt', 'cmd'}))
remapKey({'ctrl', 'alt', 'cmd'}, 'n', keyCode('down', {'alt', 'cmd'}))
remapKey({'ctrl', 'alt', 'cmd'}, 'p', keyCode('up', {'alt', 'cmd'}))

remapKey({'ctrl', 'alt', 'shift'}, 'f', keyCode('right', {'alt', 'shift'}))
remapKey({'ctrl', 'alt', 'shift'}, 'b', keyCode('left', {'alt', 'shift'}))
remapKey({'ctrl', 'alt', 'shift'}, 'n', keyCode('down', {'alt', 'shift'}))
remapKey({'ctrl', 'alt', 'shift'}, 'p', keyCode('up', {'alt', 'shift'}))

remapKey({'ctrl', 'alt', 'shift', 'cmd'}, 'f', keyCode('right', {'alt', 'shift', 'cmd'}))
remapKey({'ctrl', 'alt', 'shift', 'cmd'}, 'b', keyCode('left', {'alt', 'shift', 'cmd'}))
remapKey({'ctrl', 'alt', 'shift', 'cmd'}, 'n', keyCode('down', {'alt', 'shift', 'cmd'}))
remapKey({'ctrl', 'alt', 'shift', 'cmd'}, 'p', keyCode('up', {'alt', 'shift', 'cmd'}))

remapKey({'ctrl'}, 'h', keyCode('delete'))
remapKey({'ctrl'}, '[', keyCode('escape'))
remapKey({'ctrl'}, 'a', keyCode('left', {'cmd'}))
remapKey({'ctrl'}, 'e', keyCode('right', {'cmd'}))

remapKey({'ctrl'}, "'", keyCode("`"))
