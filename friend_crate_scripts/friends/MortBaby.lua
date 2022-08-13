local MortBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/mort_baby.png")

---@param familiar EntityFamiliar
function MortBaby:OnShoot(familiar)
    for _, fly in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY)) do
        if fly:GetData().IsMortFly then
            return true
        end
    end

    local blueFly = familiar.Player:AddBlueFlies(1, familiar.Position, nil)
    blueFly:GetData().IsMortFly = true

    return false
end

FRIEND_CRATE_API.RegisterFriend(MortBaby)