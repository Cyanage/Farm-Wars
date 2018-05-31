Menu = {}

-- This bool is active if the menu is active.
isActive = false

function Menu.isActive()
    return isActive
end

-- TODO: init the game when starting the game scene.
function Menu.setActive(bool)
    isActive = true
end

function Menu.load()
    -- Create the background image and set the scale_factor to the screen.
    bg = love.graphics.newImage("resc/images/mountains.png")
    sreen_scale = love.graphics.getWidth() / bg:getWidth()

    start = love.graphics.newImage("resc/images/Start.png")
    info = love.graphics.newImage("resc/images/Info.png")

    xPosUi = love.graphics.getWidth()/2 - start:getWidth()/(1.5*1.15)
end

function Menu.draw()
    love.graphics.draw(bg, 0, 0, r, sreen_scale, sreen_scale)

    love.graphics.draw(start, xPosUi, 100 * sreen_scale, r, sreen_scale/1.5, sreen_scale/1.5)
    love.graphics.draw(info, xPosUi, 400 * sreen_scale, r, sreen_scale/1.5, sreen_scale/1.5)
end

function Menu.update()

end

return Menu
