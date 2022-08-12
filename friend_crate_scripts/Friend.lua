local Friend = {
    SPRITE = "gfx/familiars/baby_spider.png",
    BASE_STATS = {
        DAMAGE = 3.5,
        FIRE_RATE = 15,
        TEAR_FLAGS = TearFlags.TEAR_NORMAL,
        TEAR_COLOR = Color(1, 1, 1),

        PLAYER_STATS = {},
        PLAYER_EFFECTS = {}
    },

    CURRENT_STATS = {
        DAMAGE = 3.5,
        FIRE_RATE = 15,
        TEAR_FLAGS = TearFlags.TEAR_NORMAL,
        TEAR_COLOR = Color(1, 1, 1),

        PLAYER_STATS = {},
        PLAYER_EFFECTS = {}
    }
}

function Friend:New(sprite, newFriendStats)
    --Default is empty table
    newFriendStats = newFriendStats or {}

    local friend = {
        SPRITE = sprite,
        BASE_STATS = {
            DAMAGE = newFriendStats.DAMAGE or 3.5,
            FIRE_RATE = newFriendStats.FIRE_RATE or 10,
            TEAR_FLAGS = newFriendStats.TEAR_FLAGS or TearFlags.TEAR_NORMAL,
            TEAR_COLOR = newFriendStats.TEAR_COLOR or Color(1, 1, 1),

            PLAYER_STATS = newFriendStats.PLAYER_STATS or {},
            PLAYER_EFFECTS = newFriendStats.PLAYER_EFFECTS or {}
        },

        CURRENT_STATS = {
            DAMAGE = newFriendStats.DAMAGE or 3.5,
            FIRE_RATE = newFriendStats.FIRE_RATE or 10,
            TEAR_FLAGS = newFriendStats.TEAR_FLAGS or TearFlags.TEAR_NORMAL,
            TEAR_COLOR = newFriendStats.TEAR_COLOR or Color(1, 1, 1),

            PLAYER_STATS = newFriendStats.PLAYER_STATS or {},
            PLAYER_EFFECTS = newFriendStats.PLAYER_EFFECTS or {}
        }
    }

    setmetatable(friend, self)
    self.__index = self

    return friend
end


function Friend:Init()
    self.CURRENT_STATS.DAMAGE = self.BASE_STATS.DAMAGE
    self.CURRENT_STATS.FIRE_RATE = self.BASE_STATS.DAMAGE
    self.CURRENT_STATS.TEAR_FLAGS = self.BASE_STATS.TEAR_FLAGS
    self.CURRENT_STATS.TEAR_COLOR = self.BASE_STATS.TEAR_COLOR

    self.CURRENT_STATS.PLAYER_STATS = {}

    for key, value in pairs(self.BASE_STATS.PLAYER_STATS) do
        self.CURRENT_STATS.PLAYER_STATS[key] = value
    end

    self.CURRENT_STATS.PLAYER_EFFECTS = {}

    for key, value in pairs(self.BASE_STATS.PLAYER_EFFECTS) do
        self.CURRENT_STATS.PLAYER_EFFECTS[key] = value
    end
end


function Friend:OnShoot(familiar)
end


function Friend:OnUpdate(familiar)
end


function Friend:OnRoomClear(familiar)
end


return Friend