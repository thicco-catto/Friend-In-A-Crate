FRIEND_CRATE_API = {}

local Friend = require("friend_crate_scripts/Friend")
local Constants

function FRIEND_CRATE_API.NewFriend(sprite, stats)
    return Friend:New(sprite, stats)
end

function FRIEND_CRATE_API.RegisterFriend(friend)
    table.insert(Constants.FRIENDS_LIST, friend)
end

function FRIEND_CRATE_API.FloatingAnimFromDirection(dir)
    return Constants.FLOAT_ANIM_PER_DIRECTION[dir]
end

function FRIEND_CRATE_API.ShootingAnimFromDirection(dir)
    return Constants.SHOOT_ANIM_PER_DIRECTION[dir]
end

function FRIEND_CRATE_API.VectorFromDirection(dir)
    return Constants.DIRECTION_TO_VECTOR[dir]
end

local api = {}
function api.AddConstants(const)
    Constants = const
end
return api