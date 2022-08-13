local LostBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/lost_baby.png")
local game = Game()


---@param familiar EntityFamiliar
function LostBaby:OnUpdate(familiar)
    if game:GetFrameCount() % 7 ~= 0 then return end
    if familiar.Velocity:Length() < 1 then return end

    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, familiar.Position + Vector(0, -10), Vector.Zero, familiar)
end


FRIEND_CRATE_API.RegisterFriend(LostBaby)