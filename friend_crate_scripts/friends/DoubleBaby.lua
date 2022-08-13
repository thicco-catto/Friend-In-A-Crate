local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local Constants = loadFile("friend_crate_scripts/Constants")

local DoubleBaby = Friend:New("gfx/familiars/double_baby.png", {
    DAMAGE = 2
})

---@param familiar EntityFamiliar
function DoubleBaby:OnShoot(familiar)
    local fireDir = familiar.Player:GetFireDirection()
    local fireVector = Constants.DIRECTION_TO_VECTOR[fireDir]

    local blueTearOffset = Vector.Zero
    local redTearOffset = Vector.Zero

    if fireDir == Direction.DOWN then
        blueTearOffset = Vector(-7, 0)
        redTearOffset = Vector(7, 0)
    elseif fireDir == Direction.UP then
        blueTearOffset = Vector(7, 0)
        redTearOffset = Vector(-7, 0)
    elseif fireDir == Direction.LEFT then
        blueTearOffset = Vector(0, -7)
        redTearOffset = Vector(0, 7)
    elseif fireDir == Direction.RIGHT then
        blueTearOffset = Vector(0, 7)
        redTearOffset = Vector(0, -7)
    end

    local blueTear = familiar:FireProjectile(fireVector)
    blueTear.Position = blueTear.Position + blueTearOffset
    blueTear.CollisionDamage = self.CURRENT_STATS.DAMAGE

    local redTear = familiar:FireProjectile(fireVector)
    redTear.Position = redTear.Position + redTearOffset
    redTear:ChangeVariant(TearVariant.BLOOD)
    redTear.CollisionDamage = self.CURRENT_STATS.DAMAGE

    return false
end

return DoubleBaby