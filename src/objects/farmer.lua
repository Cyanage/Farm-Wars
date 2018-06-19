Farmer = {}

-- This function makes a new instance of this object.  (this is the constructor.)
function Farmer:new(pos_x, pos_y)

    self.farmer_sprites = {love.graphics.newImage("resc/images/farmer/farmer1.png"),
    love.graphics.newImage("resc/images/farmer/farmer3.png"),
    love.graphics.newImage("resc/images/farmer/farmer1.png"),
    love.graphics.newImage("resc/images/farmer/farmer4.png")
  }

    self.pos_x = pos_x
    self.pos_y = pos_y

    self.sprite = 1

    -- Add member variables here.
    selfObj = {
        m_position = position,
      }

    -- Make this a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

function Farmer:update(dt)
  farmer_time = farmer_time + dt
  if farmer_time >= 0.1 then

    farmer:moveForwards(16)

    if self.sprite >= 4 then
      self.sprite = 1
    else
      self.sprite = self.sprite + 1
    end

    farmer_time = 0
  end
end

-- This function moves the farmer forwards one tile and plays the farmer animation.
function Farmer:moveForwards(pixels)

  self.pos_x = self.pos_x + pixels
end

function Farmer:draw()

      love.graphics.draw(self.farmer_sprites[self.sprite], self.pos_x, self.pos_y, r, sx, sy, ox, oy, kx, ky)
end

return Farmer
