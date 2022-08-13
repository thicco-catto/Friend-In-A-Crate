local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local game = Game()

local SuckyBaby = Friend:New("gfx/familiars/sucky_baby.png")


function SuckyBaby:OnUpdate(familiar)
    if game:GetFrameCount() % self.CURRENT_STATS.FIRE_RATE ~= 0 then return end

    for _, entity in ipairs(Isaac.FindInRadius(familiar.Position, 70, EntityPartition.ENEMY)) do
        if entity:IsVulnerableEnemy() then
            entity:TakeDamage(self.CURRENT_STATS.DAMAGE, 0, EntityRef(familiar), 0)
        end
    end
end

return SuckyBaby