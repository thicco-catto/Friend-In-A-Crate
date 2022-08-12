FRIEND_CRATE_API = {}

local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Constants = loadFile("friend_crate_scripts/Constants")

function FRIEND_CRATE_API.RegisterFriend(friend)
    table.insert(Constants.FRIENDS_LIST, friend)
end