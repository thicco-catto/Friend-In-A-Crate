local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")

local MortBaby = Friend:New("gfx/familiars/mort_baby.png")

---@param familiar EntityFamiliar
function MortBaby:OnShoot(familiar)
    for _, fly in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY)) do
        if fly:GetData().IsMortFly then
            return true
        end
    end

    local blueFly = familiar.Player:AddBlueFlies(1, familiar.Position, nil)
    blueFly:GetData().IsMortFly = true

    return false
end

return MortBaby