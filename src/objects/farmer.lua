Farmer = {}

-- This function makes a new instance of this object.  (this is the constructor.)
function Farmer:new(position)

    self.farmer_sprites = {love.graphics.newImage("resc/images/farmer/farmer1.png"),
    love.graphics.newImage("resc/images/farmer/farmer2.png"),
    love.graphics.newImage("resc/images/farmer/farmer3.png"),
    love.graphics.newImage("resc/images/farmer/farmer4.png")
  }
    -- Add member variables here.
    selfObj = {
        m_position = position,
      }

    -- Make this a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

function Farmer:update()

end

-- This function moves the farmer forwards one tile and plays the farmer animation.
function Farmer:moveForwards()

end

function Farmer:draw(i)

      love.graphics.draw(self.farmer_sprites[i], 0, 0, r, sx, sy, ox, oy, kx, ky)
end

return Farmer
