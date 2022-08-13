local BeanBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/bean_baby.png")
local game = Game()

local FartCooldown = 0
local MAX_FART_COOLDOWN = 30

---@param familiar EntityFamiliar
function BeanBaby:OnCollision(familiar)
    if FartCooldown > 0 then
        FartCooldown = FartCooldown - 1
        return true
    end

    FartCooldown = MAX_FART_COOLDOWN

    game:Fart(familiar.Position)

    return true
end


FRIEND_CRATE_API.RegisterFriend(BeanBaby)