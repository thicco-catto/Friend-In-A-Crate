local DarkBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/dark_baby.png", {
    PLAYER_STATS = {
        [CacheFlag.CACHE_DAMAGE] = 0.5,
        [CacheFlag.CACHE_SPEED] = 0.1,
        [CacheFlag.CACHE_RANGE] = 20,
        [CacheFlag.CACHE_FIREDELAY] = -2
    }
})

FRIEND_CRATE_API.RegisterFriend(DarkBaby)