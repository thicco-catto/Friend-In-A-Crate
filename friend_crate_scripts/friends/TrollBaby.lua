local TrollBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/troll_baby.png")


---@param familiar EntityFamiliar
function TrollBaby:OnUpdate(familiar)
    if familiar:GetData().ShootAnimFrames > 0 then return end

    local rng = familiar:GetDropRNG()
    if rng:RandomInt(1000) < 3 then
        familiar:GetData().ShootAnimFrames = 16

        local fireDir = familiar.Player:GetFireDirection()
        if fireDir == Direction.NO_DIRECTION then
            fireDir = Direction.DOWN
        end
        familiar:GetSprite():Play(FRIEND_CRATE_API.ShootingAnimFromDirection(fireDir), true)

        --Spawn troll bomb
        local variant = BombVariant.BOMB_TROLL
        if familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
            variant = BombVariant.BOMB_SUPERTROLL
        end
        Isaac.Spawn(EntityType.ENTITY_BOMB, variant, 0, familiar.Position + Vector(0, -5), Vector.Zero, nil)

        SFXManager():Play(SoundEffect.SOUND_BROWNIE_LAUGH, 1, 2, false, math.random(-1, 1)*0.2 + 1)
    end
end


FRIEND_CRATE_API.RegisterFriend(TrollBaby)