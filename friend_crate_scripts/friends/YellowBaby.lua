local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local YellowBaby = Friend:New("gfx/familiars/yellow_baby.png", {
    PLAYER_STATS = {
        [CacheFlag.CACHE_SPEED] = 0.2
    }
})

return YellowBaby