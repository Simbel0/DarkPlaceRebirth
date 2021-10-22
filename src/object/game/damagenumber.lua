local DamageNumber, super = Class(Object)

-- Types: "mercy", "damage", "msg"
-- Arg:
--    "mercy"/"damage": amount
--    "msg": message sprite name ("down", "frozen", "lost", "max", "mercy", "miss", "recruit", and "up")

function DamageNumber:init(type, arg, x, y, color)
    super:init(self, x, y)

    self:setOrigin(1, 0)

    self.color = color or {1, 1, 1}

    self.type = type or "msg"
    if self.type == "msg" then
        self.message = arg or "miss"
    else
        self.amount = arg or 0
        if self.type == "mercy" then
            self.font = Assets.getFont("goldnumbers")
            if self.amount == 100 then
                self.type = "msg"
                self.message = "mercy"
            elseif self.amount < 0 then
                self.text = self.amount.."%"
                self.color = {self.color[1] * 0.75, self.color[2] * 0.75, self.color[3] * 0.75}
            else
                self.text = "+"..self.amount.."%"
            end
        else
            self.text = tostring(self.amount)
            self.font = Assets.getFont("bignumbers")
        end
    end

    if self.message then
        self.texture = Assets.getTexture("ui/battle/msg/"..self.message)
        self.width = self.texture:getWidth()
        self.height = self.texture:getHeight()
    elseif self.text then
        self.width = self.font:getWidth(self.text)
        self.height = self.font:getHeight()
    end

    self.timer = 0
    self.delay = 2

    self.bounces = 0

    self.stretch = 0.2
    self.stretch_done = false

    self.start_x = nil
    self.start_y = nil

    self.speed_x = 10
    self.speed_y = (-5 - (math.random() * 2))
    self.start_speed_y = self.speed_y

    self.kill_timer = 0
    self.killing = false
    self.kill = 0
end

function DamageNumber:onAdd(parent)
    for _,v in ipairs(parent.children) do
        if isClass(v) and v:includes(DamageNumber) then
            v.kill_timer = 0
        end
    end
end

function DamageNumber:update(dt)
    if not self.start_x then
        self.start_x = self.x
        self.start_y = self.y
    end

    self.x = self.x + ((self.speed_x * 2) * DTMULT)
    self.y = self.y + ((self.speed_y) * DTMULT)

    self.timer = self.timer + DTMULT
    if self.timer >= self.delay then
        self.speed_x = Utils.approach(self.speed_x, 0, DTMULT)
        if math.abs(self.speed_x) < 1 then
            self.speed_x = 0
        end

        if self.bounces < 2 then
            self.speed_y = self.speed_y + DTMULT

            if self.y > self.start_y and not self.killing then
                self.y = self.start_y

                self.speed_y = self.start_speed_y / 2
                self.bounces = self.bounces + 1
            end
        end
        if self.bounces >= 2 and not self.killing then
            self.speed_y = 0
            self.y = self.start_y
        end

        if not self.stretch_done then
            self.stretch = self.stretch + 0.4 * DTMULT

            if self.stretch >= 1.2 then
                self.stretch = 1
                self.stretch_done = true
            end
        end

        self.kill_timer = self.kill_timer + DTMULT
        if self.kill_timer > 35 then
            self.killing = true
        end
        if self.killing then
            self.kill = self.kill + 0.08 * DTMULT
            self.y = self.y - 4 * DTMULT
        end

        if self.kill > 1 then
            self:remove()
            return
        end
    end

    self:updateChildren(dt)
end

function DamageNumber:draw()
    if self.timer >= self.delay then
        local r, g, b, a = self:getDrawColor()
        love.graphics.setColor(r, g, b, a * (1 - self.kill))

        if self.texture then
            love.graphics.draw(self.texture, 30, 0, 0, (2 - self.stretch), (self.stretch + self.kill))
        elseif self.text then
            love.graphics.setFont(self.font)
            love.graphics.print(self.text, 30, 0, 0, (2 - self.stretch), (self.stretch + self.kill))
        end
    end

    self:drawChildren()
end

return DamageNumber