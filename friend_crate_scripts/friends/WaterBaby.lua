local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local Constants = loadFile("friend_crate_scripts/Constants")

local WaterBaby = Friend:New("gfx/familiars/water_baby.png")


function WaterBaby:OnShoot()
    return true
end


---@param familiar EntityFamiliar
function WaterBaby:OnCollision(familiar)
    if familiar:GetData().ShootAnimFrames > 0 then return true end

    familiar:GetData().ShootAnimFrames = 16

    for x = -1, 1, 1 do
        for y = -1, 1, 1 do
            if x ~= 0 or y ~= 0 then
                local tear = familiar:FireProjectile(Vector(x, y):Normalized())
                tear.CollisionDamage = self.CURRENT_STATS.DAMAGE
            end
        end
    end

    local fireDir = familiar.Player:GetFireDirection()
    if fireDir == Direction.NO_DIRECTION then
        fireDir = Direction.DOWN
    end
    familiar:GetSprite():Play(Constants.SHOOT_ANIM_PER_DIRECTION[fireDir], true)

    return true
end

return WaterBaby