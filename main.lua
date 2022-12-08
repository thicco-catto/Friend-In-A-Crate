local FriendCrateMod = RegisterMod("FriendCrateMod", 1)


local Constants = require("friend_crate_scripts/Constants")

local api = require("friend_crate_scripts/FriendCrateAPI")
api.AddConstants(Constants)
require("friend_crate_scripts/RegisterFriends")

local FriendCrateScript = require("friend_crate_scripts/FriendCrate")
FriendCrateScript.AddConstants(Constants)
FriendCrateScript.AddCallbacks(FriendCrateMod)

local TrolledChallenge = require("friend_crate_scripts/TrolledChallenge")
TrolledChallenge.AddConstants(Constants)
TrolledChallenge.AddCallbacks(FriendCrateMod)

local FamilyGuy = require("friend_crate_scripts/FamilyGuy")
FamilyGuy.AddConstants(Constants)
FamilyGuy.AddCallbacks(FriendCrateMod)

require("friend_crate_scripts/compatibility/EIDCompat")