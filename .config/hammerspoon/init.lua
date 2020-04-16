--[[
TODO:
  0. CLEAN THIS UP
    - A bunch is commented out rn since I'm trying to find a way to remap keys
      without hammerspoon, so plz ignore how nasty this whole file is
  1. Lines 361-400 and 516-521 in
      https://github.com/cmsj/hammerspoon-config/blob/master/init.lua
--]]

-- START General

-- Print out more logging for me to see
-- require("hs.crash")
-- hs.crash.crashLogToNSLog = false

-- command line interface
-- require("hs.ipc")
-- hs.ipc.cliInstall()

-- allows easy install of other spoons
-- https://www.hammerspoon.org/Spoons/SpoonInstall.html#updateAllRepos
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall.use_syncinstall = true
Install=spoon.SpoonInstall

Install:andUse("FnMate")
Install:andUse("ReloadConfiguration", { start = true })

-- make the console use darkmode colors
hs.console.darkMode(true)
if hs.console.darkMode() then
    hs.console.outputBackgroundColor{ white = 0 }
    hs.console.consoleCommandColor{ white = 1 }
    hs.console.alpha(1)
end

-- END General

-- START Key remapping

-- function used for remapping keys
-- Credit:
-- https://github.com/kkamdooong/hammerspoon-control-hjkl-to-arrow/blob/master/init.lua
local function pressFn(mods, key)
if key == nil then
    key = mods
    mods = {}
end

return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

-- function used for remapping keys
-- Credit:
-- https://github.com/kkamdooong/hammerspoon-control-hjkl-to-arrow/blob/master/init.lua
local function remap(mods, key, pressFn)
    hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end


remap({'ctrl'}, 'h', pressFn('left'))
remap({'ctrl'}, 'j', pressFn('down'))
remap({'ctrl'}, 'k', pressFn('up'))
remap({'ctrl'}, 'l', pressFn('right'))

-- NOTE: I've strictly been using my external keyboard and I think this has
-- been causing som eissues, so I'm removing the if statment

-- remapping ctrl+hjkl to fn+hjkl when using my external keyboard
-- Only want to do this if my external keyboard is available, so we run an ugly
-- command to check
-- result = hs.execute('ioreg -p IOUSB -w0 | sed "s/[^o]*o //; s/@.*$//" | grep -v "^Root.*" | grep -F "Ducky One2 Mini"')

-- if the external keyboard is connected, do some remaps
-- if result ~= "" then
--     remap({'ctrl'}, 'h', pressFn('left'))
--     remap({'ctrl'}, 'j', pressFn('down'))
--     remap({'ctrl'}, 'k', pressFn('up'))
--     remap({'ctrl'}, 'l', pressFn('right'))
-- end

-- END Key remapping
