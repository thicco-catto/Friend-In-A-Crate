local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local ShadowBaby = Friend:New("gfx/familiars/shadow_baby.png", {
    DAMAGE = 4,
})

return ShadowBaby