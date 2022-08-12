local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local PsyBaby = Friend:New("gfx/familiars/psy_baby.png", {
    FIRE_RATE = 25,
    TEAR_FLAGS = TearFlags.TEAR_HOMING,
    TEAR_COLOR = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549),
})

return PsyBaby