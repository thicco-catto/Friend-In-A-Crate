local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end

-- local beanBaby = loadFile("friend_crate_scripts/friends/BeanBaby")
-- FRIEND_CRATE_API.RegisterFriend(beanBaby)

-- local begottenBaby = loadFile("friend_crate_scripts/friends/BegottenBaby")
-- FRIEND_CRATE_API.RegisterFriend(begottenBaby)

-- local belialBaby = loadFile("friend_crate_scripts/friends/BelialBaby")
-- FRIEND_CRATE_API.RegisterFriend(belialBaby)

-- local bigBaby = loadFile("friend_crate_scripts/friends/BigBaby")
-- FRIEND_CRATE_API.RegisterFriend(bigBaby)

-- local cockeyedBaby = loadFile("friend_crate_scripts/friends/CockeyedBaby")
-- FRIEND_CRATE_API.RegisterFriend(cockeyedBaby)

-- local cryBaby = loadFile("friend_crate_scripts/friends/CryBaby")
-- FRIEND_CRATE_API.RegisterFriend(cryBaby)

-- local cyBaby = loadFile("friend_crate_scripts/friends/CyBaby")
-- FRIEND_CRATE_API.RegisterFriend(cyBaby)

-- local darkBaby = loadFile("friend_crate_scripts/friends/DarkBaby")
-- FRIEND_CRATE_API.RegisterFriend(darkBaby)

-- local doubleBaby = loadFile("friend_crate_scripts/friends/DoubleBaby")
-- FRIEND_CRATE_API.RegisterFriend(doubleBaby)

-- local drippingBaby = loadFile("friend_crate_scripts/friends/DrippingBaby")
-- FRIEND_CRATE_API.RegisterFriend(drippingBaby)

-- local glassBaby = loadFile("friend_crate_scripts/friends/GlassBaby")
-- FRIEND_CRATE_API.RegisterFriend(glassBaby)

-- local greenBaby = loadFile("friend_crate_scripts/friends/GreenBaby")
-- FRIEND_CRATE_API.RegisterFriend(greenBaby)

-- local longBaby = loadFile("friend_crate_scripts/friends/LongBaby")
-- FRIEND_CRATE_API.RegisterFriend(longBaby)

-- local lilBaby = loadFile("friend_crate_scripts/friends/LilBaby")
-- FRIEND_CRATE_API.RegisterFriend(lilBaby)

-- local lostBaby = loadFile("friend_crate_scripts/friends/LostBaby")
-- FRIEND_CRATE_API.RegisterFriend(lostBaby)

-- local mortBaby = loadFile("friend_crate_scripts/friends/MortBaby")
-- FRIEND_CRATE_API.RegisterFriend(mortBaby)

-- local nooseBaby = loadFile("friend_crate_scripts/friends/NooseBaby")
-- FRIEND_CRATE_API.RegisterFriend(nooseBaby)

-- local psyBaby = loadFile("friend_crate_scripts/friends/PsyBaby")
-- FRIEND_CRATE_API.RegisterFriend(psyBaby)

-- local rageBaby = loadFile("friend_crate_scripts/friends/RageBaby")
-- FRIEND_CRATE_API.RegisterFriend(rageBaby)

-- local revengeBaby = loadFile("friend_crate_scripts/friends/RevengeBaby")
-- FRIEND_CRATE_API.RegisterFriend(revengeBaby)

-- local shadowBaby = loadFile("friend_crate_scripts/friends/ShadowBaby")
-- FRIEND_CRATE_API.RegisterFriend(shadowBaby)

-- local spiderBaby = loadFile("friend_crate_scripts/friends/SpiderBaby")
-- FRIEND_CRATE_API.RegisterFriend(spiderBaby)

-- local superGreedBaby = loadFile("friend_crate_scripts/friends/SuperGreedBaby")
-- FRIEND_CRATE_API.RegisterFriend(superGreedBaby)

-- local trollBaby = loadFile("friend_crate_scripts/friends/TrollBaby")
-- FRIEND_CRATE_API.RegisterFriend(trollBaby)

local waterBaby = loadFile("friend_crate_scripts/friends/WaterBaby")
FRIEND_CRATE_API.RegisterFriend(waterBaby)

-- local whoreBaby = loadFile("friend_crate_scripts/friends/WhoreBaby")
-- FRIEND_CRATE_API.RegisterFriend(whoreBaby)

-- local yellowBaby = loadFile("friend_crate_scripts/friends/YellowBaby")
-- FRIEND_CRATE_API.RegisterFriend(yellowBaby)