local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local game = Game()

local BeanBaby = Friend:New("gfx/familiars/bean_baby.png")

local FartCooldown = 0
local MAX_FART_COOLDOWN = 30

---@param familiar EntityFamiliar
function BeanBaby:OnCollision(familiar)
    if FartCooldown > 0 then
        FartCooldown = FartCooldown - 1
        return true
    end

    FartCooldown = MAX_FART_COOLDOWN

    game:Fart(familiar.Position)

    return true
end

return BeanBaby