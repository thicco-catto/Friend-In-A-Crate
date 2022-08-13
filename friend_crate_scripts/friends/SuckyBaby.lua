local SuckyBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/sucky_baby.png")
local game = Game()

local FakeSuccubusAuraVariant = Isaac.GetEntityVariantByName("Fake Succubus Aura")


function SuckyBaby:OnInit(familiar)
    local fakeAura = Isaac.Spawn(EntityType.ENTITY_EFFECT, FakeSuccubusAuraVariant, 0, familiar.Position, Vector.Zero, familiar)
    familiar.Child = fakeAura
end


function SuckyBaby:OnUpdate(familiar)
    local fakeAura = familiar.Child
    if familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
        fakeAura:GetSprite():Play("IdleBig", true)
    else
        fakeAura:GetSprite():Play("Idle", true)
    end
    fakeAura.Position = familiar.Position

    if game:GetFrameCount() % self.CURRENT_STATS.FIRE_RATE ~= 0 then return end

    local range = 110
    if familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
        range = 140
    end

    for _, entity in ipairs(Isaac.FindInRadius(familiar.Position, range, EntityPartition.ENEMY)) do
        if entity:IsVulnerableEnemy() then
            entity:TakeDamage(self.CURRENT_STATS.DAMAGE, 0, EntityRef(familiar), 0)
        end
    end
end


FRIEND_CRATE_API.RegisterFriend(SuckyBaby)