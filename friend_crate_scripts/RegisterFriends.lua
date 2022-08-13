local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end

loadFile("friend_crate_scripts/friends/BeanBaby")

loadFile("friend_crate_scripts/friends/BegottenBaby")

loadFile("friend_crate_scripts/friends/BelialBaby")

loadFile("friend_crate_scripts/friends/BigBaby")

loadFile("friend_crate_scripts/friends/CockeyedBaby")

loadFile("friend_crate_scripts/friends/CryBaby")

loadFile("friend_crate_scripts/friends/CyBaby")

loadFile("friend_crate_scripts/friends/DarkBaby")

loadFile("friend_crate_scripts/friends/DeadBaby")

loadFile("friend_crate_scripts/friends/DoubleBaby")

loadFile("friend_crate_scripts/friends/DrippingBaby")

loadFile("friend_crate_scripts/friends/GlassBaby")

loadFile("friend_crate_scripts/friends/GreenBaby")

loadFile("friend_crate_scripts/friends/LongBaby")

loadFile("friend_crate_scripts/friends/LilBaby")

loadFile("friend_crate_scripts/friends/LostBaby")

loadFile("friend_crate_scripts/friends/MortBaby")

loadFile("friend_crate_scripts/friends/NooseBaby")

loadFile("friend_crate_scripts/friends/PsyBaby")

loadFile("friend_crate_scripts/friends/RageBaby")

loadFile("friend_crate_scripts/friends/RevengeBaby")

loadFile("friend_crate_scripts/friends/ShadowBaby")

loadFile("friend_crate_scripts/friends/SpiderBaby")

loadFile("friend_crate_scripts/friends/SuckyBaby")

loadFile("friend_crate_scripts/friends/SuperGreedBaby")

loadFile("friend_crate_scripts/friends/TrollBaby")

loadFile("friend_crate_scripts/friends/WaterBaby")

loadFile("friend_crate_scripts/friends/WhoreBaby")

loadFile("friend_crate_scripts/friends/YellowBaby")