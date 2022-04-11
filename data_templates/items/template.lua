-- Create an item and specify its ID (id is optional, defaults to file path)
local item, super = Class(Item, "test_item")

function item:init()
    super:init(self)

    -- Display name
    self.name = "Test Item"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Example item."

    -- Shop buy price
    self.buy_price = 0
    -- Shop sell price (usually half of buy price)
    self.sell_price = 0

    -- Consumable target mode (party, enemy, noselect, or none/nil)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
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

-- Function overrides go here

return item