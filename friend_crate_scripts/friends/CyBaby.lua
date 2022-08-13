local CyBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/cy_baby.png", {
    FIRE_RATE = 25,
    DAMAGE = 2
})

local LaserTimer = 0
local MAX_LASER_TIMER = 10

---@param familiar EntityFamiliar
function CyBaby:OnUpdate(familiar)
    local player = familiar.Player
    if player:GetFireDirection() == Direction.NO_DIRECTION then return end

    if LaserTimer > 0 then
        LaserTimer = LaserTimer - 1
        return
    end

    local rng = familiar:GetDropRNG()
    if rng:RandomInt(100) < 15 then
        LaserTimer = MAX_LASER_TIMER

        local laserDamage = 1
        if familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
            laserDamage = 2
        end

        player:FireTechLaser(familiar.Position, LaserOffset.LASER_TECH5_OFFSET,
        FRIEND_CRATE_API.VectorFromDirection(player:GetFireDirection()), false, false, familiar, 1/player.Damage * laserDamage)
    end
end


FRIEND_CRATE_API.RegisterFriend(CyBaby)