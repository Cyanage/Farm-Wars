Money = {}

-- This function makes a new instance of this object.  (this is the constructor.)
function Money:new()
    -- Add member variables here.
    selfObj = {
        total_money = 50,
        money_per_turn = -5,
        time = 0,
        button_clicked = false
    }

    selfObj.time = os.time()

    --print (selfObj.total_money)

    -- Make this a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

function Money:update()
    if os.time() - self.time >= 1 then
        self.total_money = self.total_money + self.money_per_turn
        self.time = os.time()
        --print (self.total_money)
    end

    if self.total_money <= 0 then
        --print ("you've lost")
    end
end

function Money:add_money_per_turn(a)
  self.money_per_turn = self.money_per_turn + a
end

function Money:add_money(money)
  self.total_money = self.total_money + money
end

function Money:get_current_money()
  return self.total_money
end

function Money:draw(pos_x, pos_y)
  love.graphics.print(self.total_money, pos_x, pos_y, r, sx, sy, ox, oy, kx, ky)
end

return Money
