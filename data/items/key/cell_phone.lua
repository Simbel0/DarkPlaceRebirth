local item, super = Class(Item, "cell_phone")

function item:init()
    super:init(self)

    -- Display name
    self.name = "Cell Phone"

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "It can be used to make calls."

    -- Shop buy price
    self.buy_price = 0
    -- Shop sell price (usually half of buy price)
    self.sell_price = nil

    -- Consumable target mode (party, enemy, noselect, or none/nil)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "world"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {}
end

function item:onWorldUse()
    Game.world:startCutscene(function(cutscene)
        Assets.playSound("snd_phone", 0.7)
        cutscene:text("* (You tried to call on the Cell\nPhone.)", nil, nil, {advance = false})
        cutscene:wait(40/30)
        local was_playing = Game.world.music:isPlaying()
        if was_playing then
            Game.world.music:pause()
        end
        Assets.playSound("snd_smile")
        cutscene:wait(200/30)
        if was_playing then
            Game.world.music:resume()
        end
        cutscene:text("* It's nothing but garbage noise.")
    end)
end

return item