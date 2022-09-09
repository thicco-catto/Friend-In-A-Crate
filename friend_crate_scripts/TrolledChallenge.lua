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


function TrolledChallenge.AddCallbacks(mod)
    mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, TrolledChallenge.OnPlayerInit)
end


function TrolledChallenge.AddConstants(const)
    Constants = const
end

return TrolledChallenge