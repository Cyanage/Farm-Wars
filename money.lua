
Money = {}

function Money:load()

  self.total_money = 50
  self.money_per_turn = 1
  self.time = os.time()

  print (self.total_money)
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
