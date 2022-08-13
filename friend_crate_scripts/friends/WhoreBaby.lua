local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local WhoreBaby = Friend:New("gfx/familiars/whore_baby.png", {
    TEAR_VARIANT = TearVariant.BLOOD,
    PLAYER_COLLECTIBLE_EFFECTS = {
        CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON,
    }
})

return WhoreBaby