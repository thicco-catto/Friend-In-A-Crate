local function loadFile(loc, ...)
    local _, err = pcall(require, "")
    local modName = err:match("/mods/(.*)/%.lua")
    local path = "mods/" .. modName .. "/"
    return assert(loadfile(path .. loc .. ".lua"))(...)
end
local Friend = loadFile("friend_crate_scripts/Friend")
local game = Game()

local BeanBaby = Friend:New("gfx/familiars/bean_baby.png")


function BeanBaby:OnShoot()
    return true
end


---@param familiar EntityFamiliar
function BeanBaby:OnCollision(familiar)
    if familiar:GetData().ShootAnimFrames > 0 then return true end

    familiar:GetData().ShootAnimFrames = 16

    game:Fart(familiar.Position)

    return true
end

return BeanBaby