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
end

function Menu.draw()
    love.graphics.draw(bg, 0, 0, r, sreen_scale, sreen_scale)
    love.graphics.draw(start, 400, 200, r, sreen_scale, sreen_scale)
    love.graphics.draw(info, 400, 400, r, sreen_scale, sreen_scale)
end

function Menu.update()

end

return Menu
