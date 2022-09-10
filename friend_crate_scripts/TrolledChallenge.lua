local TrolledChallenge = {}
local Constants
local game = Game()


---@param player EntityPlayer
function TrolledChallenge:OnPlayerInit(player)
    if Isaac.GetChallenge() ~= Constants.TROLLED_CHALLENGE then return end

    player:AddCollectible(Constants.FRIEND_CRATE_ITEM)
    player:AddCollectible(Constants.FRIEND_CRATE_ITEM)
    player:AddCollectible(CollectibleType.COLLECTIBLE_BFFS)
end


function TrolledChallenge:OnCollectibleInit(collectible)
    if Isaac.GetChallenge() ~= Constants.TROLLED_CHALLENGE then return end

    local room = Game():GetRoom()

    if room:GetType() ~= RoomType.ROOM_SHOP and room:GetType() ~= RoomType.ROOM_TREASURE and
    room:GetType() ~= RoomType.ROOM_PLANETARIUM then return end

    local trolledEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, Constants.TROLLED_EFFECT, 0, collectible.Position, Vector.Zero, nil)
    trolledEffect:GetSprite():Play("appear", true)

    collectible:Remove()

    game:GetHUD():ShowItemText("Troll baby strikes again", "")
    SFXManager():Play(Constants.SICKO_MODE_SOUND)
end


function TrolledChallenge:OnTrolledEffect(effect)
    if effect:GetSprite():IsFinished("appear") then
        effect:Remove()
    end
end


function TrolledChallenge.AddCallbacks(mod)
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, TrolledChallenge.OnPlayerInit)
    mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, TrolledChallenge.OnCollectibleInit, PickupVariant.PICKUP_COLLECTIBLE)
    mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, TrolledChallenge.OnTrolledEffect, Constants.TROLLED_EFFECT)
end


function TrolledChallenge.AddConstants(const)
    Constants = const
end

return TrolledChallenge