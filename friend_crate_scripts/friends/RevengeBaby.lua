local RevengeBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/revenge_baby.png", {
    TEAR_VARIANT = TearVariant.BLOOD,

    PLAYER_STATS = {
        [CacheFlag.CACHE_DAMAGE] = 1.5
    }
})

FRIEND_CRATE_API.RegisterFriend(RevengeBaby)