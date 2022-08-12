local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local DrippingBaby = Friend:New("gfx/familiars/dripping_baby.png", {
    PLAYER_COLLECTIBLE_EFFECTS = {
        CollectibleType.COLLECTIBLE_ANEMIC,
    }
})

return DrippingBaby