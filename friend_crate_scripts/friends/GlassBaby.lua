local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local game = Game()

local GlassBaby = Friend:New("gfx/familiars/glass_baby.png")


function GlassBaby:OnRoomClear(familiar)
    local rng = familiar:GetDropRNG()

    local chosenVariant = 0
    local chosenSubType = 0
    local randomChance = rng:RandomInt(100)

    if randomChance < 20 then -- Coin
        chosenVariant = PickupVariant.PICKUP_COIN
    elseif randomChance < 40 then --Bomb
        chosenVariant = PickupVariant.PICKUP_BOMB
    elseif randomChance < 60 then -- Key
        chosenVariant = PickupVariant.PICKUP_KEY
    elseif randomChance < 80 then -- Heart
        chosenVariant = PickupVariant.PICKUP_HEART
    elseif randomChance < 87 then -- Pill
        chosenVariant = PickupVariant.PICKUP_PILL
    elseif randomChance < 94 then -- Card
        chosenVariant = PickupVariant.PICKUP_TAROTCARD
        chosenSubType = game:GetItemPool():GetCard(rng:Next(), true, false, false)
    else -- Rune
        chosenVariant = PickupVariant.PICKUP_TAROTCARD
        chosenSubType = game:GetItemPool():GetCard(rng:Next(), false, true, true)
    end

    local room = game:GetRoom()
    local spawningPos = room:FindFreePickupSpawnPosition(familiar.Position, 1, true, false)

    Isaac.Spawn(EntityType.ENTITY_PICKUP, chosenVariant, chosenSubType, spawningPos, Vector.Zero, nil)
end

return GlassBaby