local Friend = {
    SPRITE = "gfx/familiars/baby_spider.png",
    BASE_STATS = {
        DAMAGE = 3.5,
        FIRE_RATE = 20,
        TEAR_FLAGS = TearFlags.TEAR_NORMAL,
        TEAR_VARIANT = TearVariant.BLUE,
        TEAR_COLOR = Color(1, 1, 1),

        PLAYER_STATS = {},

        PLAYER_COLLECTIBLE_EFFECTS = {},
        PLAYER_TRINKET_EFFECTS = {},
        PLAYER_NULL_EFFECTS = {}
    },

    CURRENT_STATS = {
        DAMAGE = 3.5,
        FIRE_RATE = 20,
        TEAR_FLAGS = TearFlags.TEAR_NORMAL,
        TEAR_VARIANT = TearVariant.BLUE,
        TEAR_COLOR = Color(1, 1, 1),

        PLAYER_STATS = {},
    }
}

function Friend:New(sprite, newFriendStats)
    --Default is empty table
    newFriendStats = newFriendStats or {}

    local friend = {
        SPRITE = sprite,
        BASE_STATS = {
            DAMAGE = newFriendStats.DAMAGE or 3.5,
            FIRE_RATE = newFriendStats.FIRE_RATE or 20,
            TEAR_FLAGS = newFriendStats.TEAR_FLAGS or TearFlags.TEAR_NORMAL,
            TEAR_VARIANT = newFriendStats.TEAR_VARIANT or TearVariant.BLUE,
            TEAR_COLOR = newFriendStats.TEAR_COLOR or Color(1, 1, 1),

            PLAYER_STATS = newFriendStats.PLAYER_STATS or {},

            PLAYER_COLLECTIBLE_EFFECTS = newFriendStats.PLAYER_COLLECTIBLE_EFFECTS or {},
            PLAYER_TRINKET_EFFECTS = newFriendStats.PLAYER_TRINKET_EFFECTS or {},
            PLAYER_NULL_EFFECTS = newFriendStats.PLAYER_NULL_EFFECTS or {}
        },

        CURRENT_STATS = {
            DAMAGE = newFriendStats.DAMAGE or 3.5,
            FIRE_RATE = newFriendStats.FIRE_RATE or 20,
            TEAR_FLAGS = newFriendStats.TEAR_FLAGS or TearFlags.TEAR_NORMAL,
            TEAR_VARIANT = newFriendStats.TEAR_VARIANT or TearVariant.BLUE,
            TEAR_COLOR = newFriendStats.TEAR_COLOR or Color(1, 1, 1),

            PLAYER_STATS = newFriendStats.PLAYER_STATS or {},
        }
    }

    setmetatable(friend, self)
    self.__index = self

    return friend
end


function Friend:Init(familiar)
    self.CURRENT_STATS.DAMAGE = self.BASE_STATS.DAMAGE
    self.CURRENT_STATS.FIRE_RATE = self.BASE_STATS.FIRE_RATE
    self.CURRENT_STATS.TEAR_FLAGS = self.BASE_STATS.TEAR_FLAGS
    self.CURRENT_STATS.TEAR_VARIANT = self.BASE_STATS.TEAR_VARIANT
    self.CURRENT_STATS.TEAR_COLOR = self.BASE_STATS.TEAR_COLOR

    self.CURRENT_STATS.PLAYER_STATS = {}

    for key, value in pairs(self.BASE_STATS.PLAYER_STATS) do
        self.CURRENT_STATS.PLAYER_STATS[key] = value
    end

    for _, collectibleId in pairs(self.BASE_STATS.PLAYER_COLLECTIBLE_EFFECTS) do
        familiar.Player:GetEffects():AddCollectibleEffect(collectibleId)
    end

    for _, trinketId in pairs(self.BASE_STATS.PLAYER_TRINKET_EFFECTS) do
        familiar.Player:GetEffects():AddTrinketEffect(trinketId)
    end

    for _, nullItemID in pairs(self.BASE_STATS.PLAYER_NULL_EFFECTS) do
        familiar.Player:GetEffects():AddNullEffect(nullItemID)
    end

    familiar:GetData().ShootAnimFrames = 0

    familiar:GetSprite():ReplaceSpritesheet(0, self.SPRITE)
    familiar:GetSprite():LoadGraphics()

    self:OnInit(familiar)
end


function Friend:OnInit(familiar)
end


function Friend:OnShoot(familiar)
end


function Friend:OnUpdate(familiar)
end


function Friend:OnRoomClear(familiar)
end


return Friend