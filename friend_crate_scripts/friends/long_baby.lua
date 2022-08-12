local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local LongBaby = Friend:New("gfx/familiars/long_baby.png", {
    PLAYER_STATS = {
        [CacheFlag.CACHE_SHOTSPEED] = 0.1,
        [CacheFlag.CACHE_RANGE] = 30
    }
})

return LongBaby