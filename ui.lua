UI = {}

LEFT = false
RIGHT = true

-- Menu controlling variables.
local drawMenu = false
local menuIsMinimized = false
local menuPosition = LEFT

-- load images
function UI.init()
    red_turn_img = love.graphics.newImage("resc/images/red_turn_bar.png")
    blue_turn_img = love.graphics.newImage("resc/images/blue_turn_bar.png")

    menu_pane_img = love.graphics.newImage("resc/images/menu_pane.png")
end

function UI.draw()
    local x_pos = pos_centered.x
    local y_pos = pos_centered.y - tile_size

    if TurnManager.currentPlayerTurn == RED then
        turn_img = red_turn_img
    else
        turn_img = blue_turn_img
    end

    love.graphics.draw(turn_img, x_pos, y_pos, 0, scale_factor, scale_factor)

    if drawMenu == true then
        if menuPosition == LEFT then
            love.graphics.draw(menu_pane_img, menu_pane_img:getWidth()*scale_factor + pos_centered.x, pos_centered.y, 0, -scale_factor, scale_factor)
        else
            love.graphics.draw(menu_pane_img, (tile_size*MAX_TILES.x) - menu_pane_img:getWidth()*scale_factor + pos_centered.x, pos_centered.y, 0, scale_factor, scale_factor)
        end
    end
end

-- This function starts drawing the menu.
function UI.openMenu(side)
    drawMenu = true
    menuPosition = side
end

-- This function stops drawing the menu.
function UI.closeMenu()
    drawMenu = false
end

function UI.toggleMenuSize()

end

function UI.update()

end


return UI
