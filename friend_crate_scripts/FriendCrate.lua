local FriendCrate = {}

local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end

local Constants = loadFile("friend_crate_scripts/Constants")

local SpiderBaby = loadFile("friend_crate_scripts/friends/troll_baby")

---@param player EntityPlayer
function FriendCrate:OnFamiliarCache(player)
    local friendCrateItemCount = player:GetCollectibleNum(Constants.FRIEND_CRATE_ITEM)
    local numBoxUses = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)

    local friendCrateFamiliarsNum = friendCrateItemCount + numBoxUses

    player:CheckFamiliar(Constants.FRIEND_CRATE_FAMILIAR_VARIANT, friendCrateFamiliarsNum,
        player:GetCollectibleRNG(Constants.FRIEND_CRATE_ITEM),
        Isaac.GetItemConfig():GetCollectible(Constants.FRIEND_CRATE_ITEM))
end


---@param familiar EntityFamiliar
function FriendCrate:OnFamiliarInit(familiar)
    familiar:GetData().FriendObject = SpiderBaby
    familiar:GetSprite():ReplaceSpritesheet(0, SpiderBaby.SPRITE)
    familiar:GetSprite():LoadGraphics()
    familiar:GetData().ShootAnimFrames = 0

    familiar:AddToFollowers()
end


---@param familiar EntityFamiliar
function FriendCrate:OnFamiliarUpdate(familiar)
    familiar:FollowParent()

    local player = familiar.Player
    local friendObject = familiar:GetData().FriendObject
	local fireDir = player:GetFireDirection()
    local sprite = familiar:GetSprite()

    friendObject:OnUpdate(familiar)

    if familiar.FireCooldown > 0 then
        familiar.FireCooldown = familiar.FireCooldown - 1
    end

    if fireDir ~= Direction.NO_DIRECTION then
        if familiar.FireCooldown > 0 then
            if familiar:GetData().ShootAnimFrames > 0 then
                familiar:GetData().ShootAnimFrames = familiar:GetData().ShootAnimFrames - 1
            else
                sprite:SetAnimation(Constants.FLOAT_ANIM_PER_DIRECTION[fireDir], false)
            end
        else
            familiar.FireCooldown = friendObject.CURRENT_STATS.FIRE_RATE

            --If OnShoot returns true, ignore the default shooting logic
            --If it returns false, player the animation but ignore the shooting
            local shouldShoot = friendObject:OnShoot()
            if shouldShoot ~= true then
                sprite:SetAnimation(Constants.SHOOT_ANIM_PER_DIRECTION[fireDir], false)
                familiar:GetData().ShootAnimFrames = 16

                if shouldShoot ~= false then
                    local familiarTear = familiar:FireProjectile(Constants.DIRECTION_TO_VECTOR[fireDir])
                    familiarTear:AddTearFlags(friendObject.CURRENT_STATS.TEAR_FLAGS)
                    familiarTear.Color = friendObject.CURRENT_STATS.TEAR_COLOR
                    familiarTear.CollisionDamage = friendObject.CURRENT_STATS.DAMAGE
                end
            end
        end
    else
        if familiar:GetData().ShootAnimFrames > 0 then
            familiar:GetData().ShootAnimFrames = familiar:GetData().ShootAnimFrames - 1
        else
            sprite:SetAnimation(Constants.FLOAT_ANIM_PER_DIRECTION[fireDir], false)
        end
    end
end


---@param player EntityPlayer
function FriendCrate:OnPeffectUpdate(player)
    for _, familiar in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Constants.FRIEND_CRATE_FAMILIAR_VARIANT)) do
        if familiar:Exists() then
            for cacheFlag, _ in pairs(familiar:GetData().FriendObject.CURRENT_STATS.PLAYER_STATS) do
                player:AddCacheFlags(cacheFlag)
            end
        end
    end
    player:EvaluateItems()
end


---@param player EntityPlayer
local function ChangeStat(player, cacheFlag, amount)
    if cacheFlag == CacheFlag.CACHE_DAMAGE then
        player.Damage = player.Damage + amount
    elseif cacheFlag == CacheFlag.CACHE_FIREDELAY then
        player.MaxFireDelay = player.MaxFireDelay + amount
    elseif cacheFlag == CacheFlag.CACHE_LUCK then
        player.Luck = player.Luck + amount
    elseif cacheFlag == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange + amount
    elseif cacheFlag == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed + amount
    elseif cacheFlag == CacheFlag.CACHE_SPEED then
        player.MoveSpeed = player.MoveSpeed + amount
    elseif cacheFlag == CacheFlag.CACHE_SIZE then
        player.SpriteScale = player.SpriteScale * amount
    end
end


function FriendCrate:OnCache(player, cacheFlag)
    for _, familiar in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Constants.FRIEND_CRATE_FAMILIAR_VARIANT)) do
        if familiar:Exists() then
            for familiarCacheFlag, amount in pairs(familiar:GetData().FriendObject.CURRENT_STATS.PLAYER_STATS) do
                if cacheFlag == familiarCacheFlag then
                    ChangeStat(player, cacheFlag, amount)
                end
            end
        end
    end
end


function FriendCrate.AddCallbacks(mod)
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, FriendCrate.OnFamiliarCache, CacheFlag.CACHE_FAMILIARS)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, FriendCrate.OnFamiliarInit, Constants.FRIEND_CRATE_FAMILIAR_VARIANT)
    mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, FriendCrate.OnFamiliarUpdate, Constants.FRIEND_CRATE_FAMILIAR_VARIANT)

    mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, FriendCrate.OnPeffectUpdate)
    mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, FriendCrate.OnCache)
end

return FriendCrate
