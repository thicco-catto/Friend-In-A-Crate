local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local DeadBaby = Friend:New("gfx/familiars/dead_baby.png")


---@param familiar EntityFamiliar
function DeadBaby:OnDealDamage(familiar, tookDamage, amount)
    if tookDamage.HitPoints <= amount then
        familiar.Player:AddBlueFlies(1, tookDamage.Position, nil)
    end
end

return DeadBaby