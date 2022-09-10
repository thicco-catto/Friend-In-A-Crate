local FriendCrateMod = RegisterMod("FriendCrateMod", 1)

local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end

local Constants = loadFile("friend_crate_scripts/Constants")

local api = loadFile("friend_crate_scripts/FriendCrateAPI")
api.AddConstants(Constants)
loadFile("friend_crate_scripts/RegisterFriends")

local FriendCrateScript = loadFile("friend_crate_scripts/FriendCrate")
FriendCrateScript.AddConstants(Constants)
FriendCrateScript.AddCallbacks(FriendCrateMod)

local TrolledChallenge = loadFile("friend_crate_scripts/TrolledChallenge")
TrolledChallenge.AddConstants(Constants)
TrolledChallenge.AddCallbacks(FriendCrateMod)

local FamilyGuy = loadFile("friend_crate_scripts/FamilyGuy")
FamilyGuy.AddConstants(Constants)
FamilyGuy.AddCallbacks(FriendCrateMod)

loadFile("friend_crate_scripts/compatibility/EIDCompat")