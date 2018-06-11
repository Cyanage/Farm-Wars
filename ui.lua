UI = {}

LEFT = false
RIGHT = true

-- Menu controlling variables.
local drawMenu = false
local menuIsMinimized = false
menuPosition = LEFT

-- load images
function UI.init()
    red_turn_img = love.graphics.newImage("resc/images/red_turn_bar.png")
    blue_turn_img = love.graphics.newImage("resc/images/blue_turn_bar.png")

    menu_pane_img = love.graphics.newImage("resc/images/menu_pane.png")

    buy_fence_pressed_img = love.graphics.newImage("resc/images/buy_fence_pressed.png")
    buy_fence_unpressed_img = love.graphics.newImage("resc/images/buy_fence_unpressed.png")
end

buy_fence_is_pressed = false
buy_fence_x = 0
buy_fence_y = 0

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
        menuPosY = pos_centered.y  -- The y position of the menu is allways going to be the same.
        if menuPosition == LEFT then
            menuPosX = menu_pane_img:getWidth()*scale_factor + pos_centered.x
            direction_mod = -1
        else
            menuPosX = (tile_size*MAX_TILES.x) - menu_pane_img:getWidth()*scale_factor + pos_centered.x
            direction_mod = 1
        end

        -- Draw the menu.
        love.graphics.draw(menu_pane_img, menuPosX, menuPosY, 0, direction_mod * scale_factor, scale_factor)

        -- Calculate the position of the button.
        if menuPosition == LEFT then
            buy_fence_x = menuPosX - 93*4*scale_factor
            buy_fence_y = menuPosY + 6*4*scale_factor
        else
            buy_fence_x = menuPosX + 51*4*scale_factor
            buy_fence_y = menuPosY + 6*4*scale_factor
        end

        -- Draw the button.
        if buy_fence_is_pressed == false then
            love.graphics.draw(buy_fence_unpressed_img, buy_fence_x, buy_fence_y, 0, scale_factor, scale_factor)
        else
            love.graphics.draw(buy_fence_pressed_img, buy_fence_x, buy_fence_y, 0, scale_factor, scale_factor)
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
