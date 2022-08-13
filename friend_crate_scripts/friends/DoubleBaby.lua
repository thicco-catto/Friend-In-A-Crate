local DoubleBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/double_baby.png", {
    DAMAGE = 2
})

---@param familiar EntityFamiliar
function DoubleBaby:OnShoot(familiar)
    local fireDir = familiar.Player:GetFireDirection()
    local fireVector = FRIEND_CRATE_API.VectorFromDirection(fireDir)

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

    if familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
        blueTear.CollisionDamage = blueTear.CollisionDamage * 2
        redTear.CollisionDamage = redTear.CollisionDamage * 2
    end

    if familiar.Player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
        blueTear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
        redTear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
    end

    return false
end

FRIEND_CRATE_API.RegisterFriend(DoubleBaby)