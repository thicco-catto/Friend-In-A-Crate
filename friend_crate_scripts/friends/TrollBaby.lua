local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local Constants = loadFile("friend_crate_scripts/Constants")

local TrollBaby = Friend:New("gfx/familiars/troll_baby.png")


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
        familiar:GetSprite():Play(Constants.SHOOT_ANIM_PER_DIRECTION[fireDir], true)

        --Spawn troll bomb
        local variant = BombVariant.BOMB_TROLL
        if familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
            variant = BombVariant.BOMB_SUPERTROLL
        end
        Isaac.Spawn(EntityType.ENTITY_BOMB, variant, 0, familiar.Position + Vector(0, -5), Vector.Zero, nil)

        SFXManager():Play(SoundEffect.SOUND_BROWNIE_LAUGH, 1, 2, false, math.random(-1, 1)*0.2 + 1)
    end
end


return TrollBaby