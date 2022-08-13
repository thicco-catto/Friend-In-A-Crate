if not EID then return end

local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Constants = loadFile("friend_crate_scripts/Constants")

EID:addCollectible(Constants.FRIEND_CRATE_ITEM,
    "#Spawns a random baby from a pool of 25" ..
    "#Changes upon entering a new room",
    "Friend in a Crate",
    "en_us"
)

EID:addCollectible(Constants.FRIEND_CRATE_ITEM,
    "#Genera un bebe aleatorio de una seleccion de 25" ..
    "#Cambia al entrar en una nueva habitacion",
    "Amigo en una Caja",
    "spa"
)