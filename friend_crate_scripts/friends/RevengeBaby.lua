local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local RevengeBaby = Friend:New("gfx/familiars/revenge_baby.png", {
    PLAYER_STATS = {
        [CacheFlag.CACHE_DAMAGE] = 1.5
    }
})

return RevengeBaby