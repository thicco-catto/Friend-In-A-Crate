local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local SuperGreedBaby = Friend:New("gfx/familiars/super_greed_baby.png", {
    TEAR_FLAGS = TearFlags.TEAR_GREED_COIN,
    TEAR_VARIANT = TearVariant.COIN,
})

return SuperGreedBaby