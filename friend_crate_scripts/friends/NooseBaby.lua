local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local NooseBaby = Friend:New("gfx/familiars/noose_baby.png", {
    PLAYER_COLLECTIBLE_EFFECTS = {
        CollectibleType.COLLECTIBLE_TRANSCENDENCE,
    }
})

return NooseBaby