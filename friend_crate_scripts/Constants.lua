local Constants = {}

Constants.FRIEND_CRATE_ITEM = Isaac.GetItemIdByName("Friend in a crate")
Constants.FRIEND_CRATE_FAMILIAR_VARIANT = Isaac.GetEntityVariantByName("Friend In A Crate")

Constants.TROLLED_CHALLENGE = Isaac.GetChallengeIdByName("Trolled")
Constants.TROLLED_EFFECT = Isaac.GetEntityVariantByName("Trolled Item Effect")
Constants.SICKO_MODE_SOUND = Isaac.GetSoundIdByName("sicko mode")

Constants.FLOAT_ANIM_PER_DIRECTION = {
	[Direction.NO_DIRECTION] = "FloatDown",
	[Direction.LEFT] = "FloatLeft",
	[Direction.UP] = "FloatUp",
	[Direction.RIGHT] = "FloatRight",
	[Direction.DOWN] = "FloatDown"
}

Constants.SHOOT_ANIM_PER_DIRECTION = {
	[Direction.NO_DIRECTION] = "FloatDown",
	[Direction.LEFT] = "FloatShootLeft",
	[Direction.UP] = "FloatShootUp",
	[Direction.RIGHT] = "FloatShootRight",
	[Direction.DOWN] = "FloatShootDown"
}

Constants.DIRECTION_TO_VECTOR = {
	[Direction.LEFT] = Vector(-1, 0),
	[Direction.UP] = Vector(0, -1),
	[Direction.RIGHT] = Vector(1, 0),
	[Direction.DOWN] = Vector(0, 1),
}

Constants.FRIENDS_LIST = {}

return Constants