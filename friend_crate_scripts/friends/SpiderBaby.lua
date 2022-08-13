local SpiderBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/spider_baby.png")
local game = Game()

local spiderCooldown = 0
local MAX_SPIDER_COOLDOWN = 20


---@param familiar EntityFamiliar
function SpiderBaby:OnUpdate(familiar)
    if spiderCooldown > 0 then
        spiderCooldown = spiderCooldown - 1
        return
    end
    if game:GetRoom():IsClear() then return end

    local rng = familiar:GetDropRNG()
    if rng:RandomInt(1000) < 5 then
        familiar:GetData().ShootAnimFrames = 16
        spiderCooldown = MAX_SPIDER_COOLDOWN

        --Shoot spiders
        local fireDir = familiar.Player:GetFireDirection()
        if fireDir == Direction.NO_DIRECTION then
            fireDir = Direction.DOWN
        end
        familiar:GetSprite():Play(FRIEND_CRATE_API.ShootingAnimFromDirection(fireDir), true)

        local spider = familiar.Player:AddBlueSpider(familiar.Position + Vector(0, -5))
        spider:GetSprite():Play("Appear", true)

        SFXManager():Play(SoundEffect.SOUND_BOIL_HATCH, 1, 2, false, math.random(-1, 1)*0.2 + 1)
    end
end


FRIEND_CRATE_API.RegisterFriend(SpiderBaby)