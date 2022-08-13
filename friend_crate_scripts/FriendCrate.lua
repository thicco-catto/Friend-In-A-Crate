local FriendCrate = {}
local game = Game()
local Constants


local function GetFriendCrateRoomRNG(player)
    local level = game:GetLevel()
    local itemRngSeed = player:GetCollectibleRNG(Constants.FRIEND_CRATE_ITEM):GetSeed()

    itemRngSeed = itemRngSeed + level:GetStage()
    itemRngSeed = itemRngSeed + level:GetCurrentRoomDesc().GridIndex

    local rng = RNG()
    rng:SetSeed(itemRngSeed, 35)

    return rng
end


---@param player EntityPlayer
function FriendCrate:OnFamiliarCache(player)
    local friendCrateItemCount = player:GetCollectibleNum(Constants.FRIEND_CRATE_ITEM)
    local numBoxUses = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS)

    local friendCrateFamiliarsNum = friendCrateItemCount + numBoxUses

    if friendCrateItemCount == 0 then
        friendCrateFamiliarsNum = 0
    end

    player:CheckFamiliar(Constants.FRIEND_CRATE_FAMILIAR_VARIANT, friendCrateFamiliarsNum,
        player:GetCollectibleRNG(Constants.FRIEND_CRATE_ITEM),
        Isaac.GetItemConfig():GetCollectible(Constants.FRIEND_CRATE_ITEM))
end


---@param familiar EntityFamiliar
function FriendCrate:OnFamiliarInit(familiar)
    local rng = GetFriendCrateRoomRNG(familiar.Player)
    local playerIndex = familiar.Player:GetCollectibleRNG(1):GetSeed()

    for _, otherFriend in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Constants.FRIEND_CRATE_FAMILIAR_VARIANT)) do
        otherFriend = otherFriend:ToFamiliar()
        local otherPlayerIndex = otherFriend.Player:GetCollectibleRNG(1):GetSeed()

        if playerIndex == otherPlayerIndex and EntityPtr(otherFriend) ~= EntityPtr(familiar) then
            --They're from the same player but different familiars
            rng:Next()
        end
    end

    local chosenFriend = Constants.FRIENDS_LIST[rng:RandomInt(#Constants.FRIENDS_LIST) + 1]

    print(Constants.FRIENDS_LIST[1])

    familiar:GetData().FriendObject = chosenFriend
    familiar:GetData().FriendObject:Init(familiar)
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
                    if friendObject.CURRENT_STATS.TEAR_VARIANT ~= TearVariant.BLUE then
                        familiarTear:ChangeVariant(friendObject.CURRENT_STATS.TEAR_VARIANT)
                    end
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
    if not player:HasCollectible(Constants.FRIEND_CRATE_ITEM) then return end

    player:AddCacheFlags(CacheFlag.CACHE_ALL)
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
    elseif cacheFlag == CacheFlag.CACHE_FLYING then
        player.CanFly = amount
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


function FriendCrate:OnNewRoom()
    for i = 0, game:GetNumPlayers() - 1, 1 do
        local player = game:GetPlayer(i)
        local playerIndex = player:GetCollectibleRNG(1):GetSeed()
        local rng = GetFriendCrateRoomRNG(player)

        for _, familiar in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Constants.FRIEND_CRATE_FAMILIAR_VARIANT)) do
            familiar = familiar:ToFamiliar()
            local otherPlayerIndex = familiar.Player:GetCollectibleRNG(1):GetSeed()

            if playerIndex == otherPlayerIndex then
                local chosenFriend = Constants.FRIENDS_LIST[rng:RandomInt(#Constants.FRIENDS_LIST) + 1]

                familiar:GetData().FriendObject = chosenFriend
                familiar:GetData().FriendObject:Init(familiar)
            end
        end
    end
end


function FriendCrate:OnRoomClear()
    for i = 0, game:GetNumPlayers() - 1, 1 do
        local player = game:GetPlayer(i)
        local playerIndex = player:GetCollectibleRNG(1):GetSeed()

        for _, familiar in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, Constants.FRIEND_CRATE_FAMILIAR_VARIANT)) do
            familiar = familiar:ToFamiliar()
            local otherPlayerIndex = familiar.Player:GetCollectibleRNG(1):GetSeed()

            if playerIndex == otherPlayerIndex then
                familiar:GetData().FriendObject:OnRoomClear(familiar)
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

    mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, FriendCrate.OnNewRoom)

    mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, FriendCrate.OnRoomClear)
end


function FriendCrate.AddConstants(const)
    Constants = const
end


return FriendCrate
