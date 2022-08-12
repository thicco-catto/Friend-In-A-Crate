local FriendCrateMod = RegisterMod("FriendCrateMod", 1)

local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end

loadFile("friend_crate_scripts/FriendCrateAPI")
loadFile("friend_crate_scripts/RegisterFriends")

local FriendCrateScript = loadFile("friend_crate_scripts/FriendCrate")
FriendCrateScript.AddCallbacks(FriendCrateMod)