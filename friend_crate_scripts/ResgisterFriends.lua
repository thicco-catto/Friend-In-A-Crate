local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end

local cryBaby = loadFile("friend_crate_scripts/friends/CryBaby")
FRIEND_CRATE_API.RegisterFriend(cryBaby)

local cyBaby = loadFile("friend_crate_scripts/friends/CyBaby")
FRIEND_CRATE_API.RegisterFriend(cyBaby)

local greenBaby = loadFile("friend_crate_scripts/friends/GreenBaby")
FRIEND_CRATE_API.RegisterFriend(greenBaby)

local longBaby = loadFile("friend_crate_scripts/friends/LongBaby")
FRIEND_CRATE_API.RegisterFriend(longBaby)

local lostBaby = loadFile("friend_crate_scripts/friends/LostBaby")
FRIEND_CRATE_API.RegisterFriend(lostBaby)

local psyBaby = loadFile("friend_crate_scripts/friends/PsyBaby")
FRIEND_CRATE_API.RegisterFriend(psyBaby)

local rageBaby = loadFile("friend_crate_scripts/friends/RageBaby")
FRIEND_CRATE_API.RegisterFriend(rageBaby)

local shadowBaby = loadFile("friend_crate_scripts/friends/ShadowBaby")
FRIEND_CRATE_API.RegisterFriend(shadowBaby)

local spiderBaby = loadFile("friend_crate_scripts/friends/SpiderBaby")
FRIEND_CRATE_API.RegisterFriend(spiderBaby)

local trollBaby = loadFile("friend_crate_scripts/friends/TrollBaby")
FRIEND_CRATE_API.RegisterFriend(trollBaby)

local yellowBaby = loadFile("friend_crate_scripts/friends/YellowBaby")
FRIEND_CRATE_API.RegisterFriend(yellowBaby)