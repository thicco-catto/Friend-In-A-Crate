local FamilyGuy = {}
local Constants


---@param player EntityPlayer
function FamilyGuy:OnPlayerInit(player)
    if Isaac.GetChallenge() ~= Constants.FAMILY_GUY_CHALLENGE then return end

    player:AddCollectible(Constants.FRIEND_CRATE_CHALLENGE_ITEM)
end


function FamilyGuy:OnCollectibleInit(collectible)
    if Isaac.GetChallenge() ~= Constants.FAMILY_GUY_CHALLENGE then return end

    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, collectible.Position, Vector.Zero, nil)

    collectible:Remove()
end


function FamilyGuy.AddCallbacks(mod)
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, FamilyGuy.OnPlayerInit)
    mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, FamilyGuy.OnCollectibleInit, PickupVariant.PICKUP_COLLECTIBLE)
end


function FamilyGuy.AddConstants(const)
    Constants = const
end

return FamilyGuy