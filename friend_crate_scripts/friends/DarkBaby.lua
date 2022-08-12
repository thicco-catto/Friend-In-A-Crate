local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local DarkBaby = Friend:New("gfx/familiars/dark_baby.png", {
    PLAYER_STATS = {
        [CacheFlag.CACHE_DAMAGE] = 0.5,
        [CacheFlag.CACHE_SPEED] = 0.1,
        [CacheFlag.CACHE_RANGE] = 20,
        [CacheFlag.CACHE_FIREDELAY] = -2
    }
})

return DarkBaby