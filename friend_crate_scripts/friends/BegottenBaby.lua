local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local BegottenBaby = Friend:New("gfx/familiars/begotten_baby.png", {
    SHOT_SPEED = 0.7,
    TEAR_VARIANT = TearVariant.DARK_MATTER,
    TEAR_FLAGS = TearFlags.TEAR_FEAR
})

return BegottenBaby