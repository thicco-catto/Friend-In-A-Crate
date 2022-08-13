local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local Constants = loadFile("friend_crate_scripts/Constants")

local CockeyedBaby = Friend:New("gfx/familiars/cockeyed_baby.png")

---@param familiar EntityFamiliar
function CockeyedBaby:OnShoot(familiar)
    local fireDir = familiar.Player:GetFireDirection()
    local fireVector = Constants.DIRECTION_TO_VECTOR[fireDir]

    local rightTearVelocity = Vector.Zero
    local leftTearVelocity = Vector.Zero

    if fireDir == Direction.DOWN then
        rightTearVelocity = Vector(-0.5, 0)
        leftTearVelocity = Vector(0.5, 0)
    elseif fireDir == Direction.UP then
        rightTearVelocity = Vector(0.5, 0)
        leftTearVelocity = Vector(-0.5, 0)
    elseif fireDir == Direction.LEFT then
        rightTearVelocity = Vector(0, -0.5)
        leftTearVelocity = Vector(0, 0.5)
    elseif fireDir == Direction.RIGHT then
        rightTearVelocity = Vector(0, 0.5)
        leftTearVelocity = Vector(0, -0.5)
    end

    local rightTear = familiar:FireProjectile((fireVector + rightTearVelocity):Normalized())
    rightTear.Position = rightTear.Position
    --rightTear:ChangeVariant(TearVariant.BLOOD)
    rightTear.CollisionDamage = self.CURRENT_STATS.DAMAGE

    local leftTear = familiar:FireProjectile((fireVector + leftTearVelocity):Normalized())
    leftTear.Position = leftTear.Position
    --leftTear:ChangeVariant(TearVariant.BLOOD)
    leftTear.CollisionDamage = self.CURRENT_STATS.DAMAGE

    return false
end

return CockeyedBaby