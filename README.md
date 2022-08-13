# Friend-In-A-Crate
Friend in a Crate is a little mod that adds a new item. It'll give you a random familiar out of a pool of 25, each with its own unique effect. The mod also allows you to easily add new babies to the pool.

## Check if the API is active
You should always check if the API is active before trying to add new babies:
```lua
 if FRIEND_CRATE_API then
   --Add babies here
 end
 ```
 
 ## Create a new friend
 Creating a new friend is as simple as using the `NewFriend` function from the API.
 
 This function takes a spritesheet as a string and, optionally, a table with all the stats. The function will return a Friend object, with its own set of functions and variables.
 
 Again, the stats table is optional and the mod will use default values if you dont give it a table or just dont add the respective entries. The possible stats that you can give your baby are:
- DAMAGE (Default 3.5): Damage that each tear will deal.
- FIRE_RATE (Default 20): Number of frames between each shot.
- SHOT_SPEED (Default 1): Multiplier that each tear's velocity will be multiplied to.
- TEAR_SCALE (Default 0.7): Scale of each tear.
- TEAR_FLAGS (Default `TearFlags.TEAR_NORMAL`): Tear flags that will be applied to the tears.
- TEAR_VARIANT (Default `TearVariant.BLUE`): Tear variant of the tears.
- TEAR_COLOR (Default `Color(1, 1, 1)`): Color that will be given to the tears.
- PLAYER_STATS (Default none): Stats that will be given to the player owner. It must be a table with `CacheFlag` as keys and numbers (or boolean in the case of flying) as entries
- PLAYER_COLLECTIBLE_EFFECTS (Default none): Collectible effects that will be applied to the player.
- PLAYER_TRINKET_EFFECTS (Default none): Trinket effects that will be applied to the player.
- PLAYER_NULL_EFFECTS (Default none): Null effects that will be applied to the player.

This example baby will fire once every 10 frames, will give the player 1.5 damage and the telepathy for dummies effect:
```lua
local myNewBaby = FRIEND_CRATE_API.NewFriend("new_baby_sprite.png", {
  FIRE_RATE = 10,
  PLAYER_STATS = {
    [CacheFlag.CACHE_DAMAGE] = 1.5
  },
  PLAYER_COLLECTIBLE_EFFECTS = {
    CollectibleType.COLLECTIBLE_TELEPATHY_BOOK
  }
}
```

## The Friend Object
The `NewFriend()` function returns a custom Friend object:

### Fields
- SPRITE: Spritesheet of the baby.
- BASE_STATS: Table with all the base stats of the baby. It has the same entries as the previous listed before. These should never be modified.
- CURRENT_STATS: Table with all the current stats of the baby. Has the same entries as the BASE_STATS table, except that it lacks the player effects lists. This table will be reset everytime the baby is initialized (on the `MC_FAMILIAR_INIT` callback and upon entering a new room). If you want to dinamically modify the baby's stats, modify the values here.

### Functions
To give your baby custom behaviour simply override as many of these functions as you want:
- `Friend:OnInit(EntityFamiliar)`: This function is called everytime the baby is initialized, just after the spritesheet has been changed and the CURRENT_STATS have been reset.
- `Friend:OnShoot(EntityFamiliar)`: This function is called whenever the baby tries to shoot. Return `true` to completely ignore the default tear firing code, and return `false` to at least play the shooting animation.
- `Friend:OnUpdate(EntityFamiliar)`: This function is called every frame, just before the `OnShoot()` function is.
- `Friend:OnRoomClear(EntityFamiliar)`: This function is called once the current room has been cleared.
- `Friend:OnCollision(EntityFamiliar)`: This function is called when the baby is colliding with an enemy or a projectile. Return `true` to actually collide with those.
- `Friend:OnDealDamage(EntityFamiliar baby, Entity tookDamage, Integer amount)`: This function will be called everytimes your baby deals damage to something.

This example baby will spawn a coin everytime it tries to shoot, instead of actually firing a tear:
```lua
local myNewBaby = FRIEND_CRATE_API.NewFriend("new_baby_sprite.png")

function myNewBaby:OnShoot(familiar)
  Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, familiar.Position, Vector.Zero, nil)
  return false
end
```

## Other helpful functions
The API also has a couple of useful functions to ease coding these babies:
- `FRIEND_CRATE_API.FloatingAnimFromDirection(Direction dir)`: Returns the corresponding floating (idle) animation given a direction.
- `FRIEND_CRATE_API.ShootingAnimFromDirection(Direction dir)`: Returns the corresponding shooting animation given a direction.
- `FRIEND_CRATE_API.VectorFromDirection(Direction dir)`: Returns a `Vector` pointing in a given direction.

## Notes
If you plan on playing shooting animations manually, do this when playing the animation so your baby looks like Vanilla familiars:
```lua
familiar:GetData().ShootAnimFrames = 16
```

If you're firing tears manually, you must account for BFFs and Baby Bender yourself.

To get more examples, simply check the code for the familiars already implemented.
