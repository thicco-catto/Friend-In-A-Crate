local DeadBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/dead_baby.png")


---@param familiar EntityFamiliar
function DeadBaby:OnDealDamage(familiar, tookDamage, amount)
    if tookDamage.HitPoints <= amount then
        familiar.Player:AddBlueFlies(1, tookDamage.Position, nil)
    end
end

FRIEND_CRATE_API.RegisterFriend(DeadBaby)