local PsyBaby = FRIEND_CRATE_API.NewFriend("gfx/familiars/psy_baby.png", {
    FIRE_RATE = 25,
    TEAR_FLAGS = TearFlags.TEAR_HOMING,
    TEAR_COLOR = Color(0.4, 0.15, 0.38, 1, 0.27843, 0, 0.4549),
})

FRIEND_CRATE_API.RegisterFriend(PsyBaby)