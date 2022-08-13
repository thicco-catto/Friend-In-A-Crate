local WaterBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/water_baby.png")

---@param familiar EntityFamiliar
function WaterBaby:OnCollision(familiar)
    if familiar:GetData().ShootAnimFrames > 0 then return true end

    familiar:GetData().ShootAnimFrames = 16

    for x = -1, 1, 1 do
        for y = -1, 1, 1 do
            if x ~= 0 or y ~= 0 then
                local tear = familiar:FireProjectile(Vector(x, y):Normalized())
                tear.CollisionDamage = self.CURRENT_STATS.DAMAGE

                if familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
                    tear.CollisionDamage = tear.CollisionDamage * 2
                end

                if familiar.Player:HasTrinket(TrinketType.TRINKET_BABY_BENDER) then
                    tear.Color = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549)
                end
            end
        end
    end

    local fireDir = familiar.Player:GetFireDirection()
    if fireDir == Direction.NO_DIRECTION then
        fireDir = Direction.DOWN
    end
    familiar:GetSprite():Play(FRIEND_CRATE_API.ShootingAnimFromDirection(fireDir), true)

    return true
end

FRIEND_CRATE_API.RegisterFriend(WaterBaby)