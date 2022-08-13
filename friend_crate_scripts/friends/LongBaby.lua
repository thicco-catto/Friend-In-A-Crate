local LongBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/long_baby.png", {
    PLAYER_STATS = {
        [CacheFlag.CACHE_SHOTSPEED] = 0.1,
        [CacheFlag.CACHE_RANGE] = 40
    }
})

FRIEND_CRATE_API.RegisterFriend(LongBaby)