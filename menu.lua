Menu = {}

-- This bool is active if the menu is active.
isActive = true

function Menu.isActive()
    return isActive
end

function Menu.setActive(bool)
    print("change")
    isActive = bool

    if bool == false then
        game.init() -- Init the game when starting the game scene.
    end
end

function Menu.load()
    -- Create the background image and set the scale_factor to the screen.
    bg = love.graphics.newImage("resc/images/mountains.png")
    screen_scale = love.graphics.getWidth() / bg:getWidth()

    -- Init images.
    start_img = love.graphics.newImage("resc/images/Start.png")
    info = love.graphics.newImage("resc/images/Info.png")

    xPosUi = love.graphics.getWidth()/2 - ( start_img:getWidth()/3 * screen_scale )

    -- Init the start button.
    start_button_function = function() Menu.setActive(false) end
    start_button = button:new( {x=xPosUi, y=150 * screen_scale}, {w=start_img:getWidth(), h=start_img:getHeight()}, "", start_button_function ) -- Start button
    start_button:setImage(start_img, screen_scale/1.5)
end

function Menu.draw()
    -- Bottom
    love.graphics.setColor(1, 1, 1, 1)  -- Colour
    love.graphics.draw(bg, 0, 0, r, sreenscreen_scale_scale, screen_scale)

    love.graphics.draw(info, xPosUi, 500 * screen_scale, 0, screen_scale/1.5, screen_scale/1.5)

    start_button:draw()
    --Top
end

function Menu.update()
    start_button:isClicked()
end

return Menu
