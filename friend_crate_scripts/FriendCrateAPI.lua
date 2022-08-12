FRIEND_CRATE_API = {}

local Constants

function FRIEND_CRATE_API.RegisterFriend(friend)
    table.insert(Constants.FRIENDS_LIST, friend)
end

local api = {}
function api.AddConstants(const)
    Constants = const
end
return api