local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local Constants = loadFile("friend_crate_scripts/Constants")
local game = Game()

local SpiderBaby = Friend:New("gfx/familiars/spider_baby.png")

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
        familiar:GetSprite():Play(Constants.SHOOT_ANIM_PER_DIRECTION[fireDir], true)

        local spider = familiar.Player:AddBlueSpider(familiar.Position + Vector(0, -5))
        spider:GetSprite():Play("Appear", true)

        SFXManager():Play(SoundEffect.SOUND_BOIL_HATCH, 1, 2, false, math.random(-1, 1)*0.2 + 1)
    end
end


return SpiderBaby