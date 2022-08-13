local RageBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/rage_baby.png", {
    TEAR_VARIANT = TearVariant.BLOOD,

    PLAYER_STATS = {
        [CacheFlag.CACHE_DAMAGE] = 1
    }
})

FRIEND_CRATE_API.RegisterFriend(RageBaby)