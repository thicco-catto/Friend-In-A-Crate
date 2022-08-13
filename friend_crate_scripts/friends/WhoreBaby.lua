local WhoreBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/whore_baby.png", {
    TEAR_VARIANT = TearVariant.BLOOD,
    PLAYER_COLLECTIBLE_EFFECTS = {
        CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON,
    }
})

FRIEND_CRATE_API.RegisterFriend(WhoreBaby)