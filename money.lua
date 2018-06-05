Money = {}

-- This function makes a new instance of this object.  (this is the constructor.)
function Enemy:new(id)
    -- Add member variables here.
    selfObj = {
        total_money = 50,
        money_per_turn = 1,
        time = 0
    }

    selfObj.time = os.time()

    print (self.total_money)

    -- Make this a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

function Money:update()
  if os.time() - self.time >= 1 then
    self.total_money = self.total_money + self.money_per_turn
    self.time = os.time()
  end
end

function Money:increase_money_per_turn(a)
  self.money_per_turn = self.money_per_turn + a
end

return Money
