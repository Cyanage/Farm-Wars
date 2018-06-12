Farmer = {}

-- This function makes a new instance of this object.  (this is the constructor.)
function Farmer:new(position)
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

function Farmer:draw()

end

return Money
