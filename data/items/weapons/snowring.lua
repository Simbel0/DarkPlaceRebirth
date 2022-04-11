local item, super = Class(Item, "snowring")

function item:init()
    super:init(self)

    -- Display name
    self.name = "SnowRing"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/ring"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "Cool\nring"
    -- Menu description
    self.description = "A ring with the emblem of the\nsnowflake"

    -- Shop buy price
    self.buy_price = 100
    -- Shop sell price (usually half of buy price)
    self.sell_price = 50

    -- Consumable target mode (party, enemy, noselect, or none/nil)
    self.target = nil
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 0,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        noelle = true,
    }

    -- Character reactions
    self.reactions = {
        susie = "Smells like Noelle",
        ralsei = "Are you... proposing?",
        noelle = "(Thank goodness...)",
    }
end

return item