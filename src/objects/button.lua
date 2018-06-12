Button = {}

-- pos is {x, y}, size is {w, h}, pass 0 to function to define no auto function.
function Button:new(pos, size, text, func)
    -- Add member variables here.
    selfObj = {
        m_pos = {x=pos.x, y=pos.y},
        m_size = {w=size.w, h=size.h},
        m_text = text,
        m_function = func,
        m_parameters = 0,
        m_font_size = 48,
        m_is_image = false,
        _image = 0,
        _scale = 1
    }

    -- Init private variables here

    -- Make this a class.
    self.__index = self
    return setmetatable(selfObj, self)
end

-- For when the passed function has paraemeters.
function Button:setParameters(param_table)
    m_parameters = param_table
end

-- Set font size of text.
function Button:setFontSize(value)
    self.m_font_size = value
end

-- Set the button to be an image.
function Button:setImage(img, scale_factor)
    self.m_is_image = true
    self._image = img

    self._scale = scale_factor
    self.m_size = { w=self.m_size.w * scale_factor, h=self.m_size.h * scale_factor }
end

-- TODO: set text colour.
function Button:setTextColour(colour)
    --pass
end

-- TODO: set background colour.
function Button:setBackgroundColour(colour)
    --pass
end

-- Check if button is being clicked when function is called.
function Button:isClicked()
    if love.mouse.isDown(1) == true and love.mouse.getX() > self.m_pos.x and love.mouse.getX() < self.m_pos.x + self.m_size.w and love.mouse.getY() > self.m_pos.y and love.mouse.getY() < self.m_pos.y + self.m_size.h then
        if self.m_function ~= nul then
            self.m_function()
        end

        return true
    end

    -- If the parser gets here, then the button has not been pressed.
    return false
end

-- Draw a filled rectangle and the text for it.
function Button:draw()
    if self.m_is_image == false then
        -- Draw rectangle.
        love.graphics.setColor(250/255, 250/255, 250/255, 255/255)  -- Colour
        love.graphics.rectangle( "fill", self.m_pos.x, self.m_pos.y, self.m_size.w, self.m_size.h )

        -- Draw string.
        love.graphics.setFont(love.graphics.newFont(self.m_font_size))
        local offset = {x=(self.m_size.w - love.graphics.getFont():getWidth(self.m_text))/2, y=0} -- Gets the width of the argument in pixels for this font.

        love.graphics.setColor(10/255, 10/255, 10/255, 255/255)  -- Colour
        love.graphics.print( self.m_text, self.m_pos.x, self.m_pos.y )
    else
        -- Draw rectangle.
        love.graphics.setColor(210/255, 210/255, 210/255, 255/255)  -- Colour
        love.graphics.rectangle( "fill", self.m_pos.x, self.m_pos.y, self.m_size.w , self.m_size.h )

        love.graphics.setColor(1, 1, 1, 1)  -- Colour
        love.graphics.draw(self._image, self.m_pos.x, self.m_pos.y, 0, self._scale, self._scale)
    end
end

--function Button:update() print "temp, update" end

return Button
