local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local game = Game()

local LostBaby = Friend:New("gfx/familiars/lost_baby.png")


function LostBaby:OnShoot()
    return true
end


---@param familiar EntityFamiliar
function LostBaby:OnUpdate(familiar)
    if game:GetFrameCount() % 7 ~= 0 then return end
    if familiar.Velocity:Length() < 1 then return end

    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, familiar.Position + Vector(0, -10), Vector.Zero, familiar)
end


return LostBaby