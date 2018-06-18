UI = {}

LEFT = false
RIGHT = true

-- Menu controlling variables.
menuPosition = LEFT
local drawMenu = false
local menuIsMinimized = false

-- load images here.
function UI.init()
    red_turn_img = love.graphics.newImage("resc/images/red_turn_bar.png")
    blue_turn_img = love.graphics.newImage("resc/images/blue_turn_bar.png")

    menu_pane_img = love.graphics.newImage("resc/images/menu_pane.png")

    buy_fence_pressed_img = love.graphics.newImage("resc/images/buy_fence_pressed.png")
    buy_fence_unpressed_img = love.graphics.newImage("resc/images/buy_fence_unpressed.png")

    end_turn_pressed_img = love.graphics.newImage("resc/images/end_turn_pressed.png")
    end_turn_unpressed_img = love.graphics.newImage("resc/images/end_turn_unpressed.png")

    claim_tile_pressed_img = love.graphics.newImage("resc/images/claim_tile_pressed.png")
    claim_tile_unpressed_img = love.graphics.newImage("resc/images/claim_tile_unpressed.png")

    improve_tile_pressed_img = love.graphics.newImage("resc/images/improve_tile_pressed.png")
    improve_tile_unpressed_img = love.graphics.newImage("resc/images/improve_tile_unpressed.png")

end

buy_fence_is_pressed = false
buy_fence_x = 0
buy_fence_y = 0

end_turn_is_pressed = false
end_turn_x = 0
end_turn_y = 0

claim_tile_is_pressed = false
claim_tile_x = 0
claim_tile_y = 0

improve_tile_is_pressed = false
improve_tile_x = 0
improve_tile_y = 0

function UI.draw()
    local x_pos = pos_centered.x
    local y_pos = pos_centered.y - tile_size

    -- Check who's turn it is and change the turn image to that colour.
    if TurnManager.currentPlayerTurn == RED then
        turn_img = red_turn_img
    else
        turn_img = blue_turn_img
    end

    -- This is the image that shows who's turn it is.
    love.graphics.draw(turn_img, x_pos, y_pos, 0, scale_factor, scale_factor)

    -- Draw the menu here.
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

        -- Calculate the position of the buy fence button.
        if menuPosition == LEFT then
            buy_fence_x = menuPosX - 51*4*scale_factor
            buy_fence_y = menuPosY + 6*4*scale_factor
        else
            buy_fence_x = menuPosX + 51*4*scale_factor
            buy_fence_y = menuPosY + 6*4*scale_factor
        end

        -- Draw the buy fence button.
        if buy_fence_is_pressed == false then
            love.graphics.draw(buy_fence_unpressed_img, buy_fence_x, buy_fence_y, 0, scale_factor, scale_factor)
        else
            love.graphics.draw(buy_fence_pressed_img, buy_fence_x, buy_fence_y, 0, scale_factor, scale_factor)
        end

        -- Calculate the position of the end turn button.
        if menuPosition == LEFT then
            end_turn_x = menuPosX - 37*4*scale_factor
            end_turn_y = menuPosY + 88*4*scale_factor
        else
            end_turn_x = menuPosX + 9*4*scale_factor
            end_turn_y = menuPosY + 88*4*scale_factor
        end

        -- Draw the end turn button.
        if end_turn_is_pressed == false then
            love.graphics.draw(end_turn_unpressed_img, end_turn_x, end_turn_y, 0, scale_factor, scale_factor)
        else
            love.graphics.draw(end_turn_pressed_img, end_turn_x, end_turn_y, 0, scale_factor, scale_factor)
        end

        -- Calculate the position of the claim tile button.
        if menuPosition == LEFT then
            claim_tile_x = menuPosX - 93*4*scale_factor
            claim_tile_y = menuPosY + 6*4*scale_factor
        else
            claim_tile_x = menuPosX + 9*4*scale_factor
            claim_tile_y = menuPosY + 6*4*scale_factor
        end

        -- Draw the claim tile button.
        if claim_tile_is_pressed == false then
            love.graphics.draw(claim_tile_unpressed_img, claim_tile_x, claim_tile_y, 0, scale_factor, scale_factor)
        else
            love.graphics.draw(claim_tile_pressed_img, claim_tile_x, claim_tile_y, 0, scale_factor, scale_factor)
        end

        -- Calculate the position of the claim tile button.
        if menuPosition == LEFT then
            improve_tile_x = menuPosX - 93*4*scale_factor
            improve_tile_y = menuPosY + 54*4*scale_factor
        else
            improve_tile_x = menuPosX + 9*4*scale_factor
            improve_tile_y = menuPosY + 54*4*scale_factor
        end

        -- Draw the claim tile button.
        if improve_tile_is_pressed == false then
            love.graphics.draw(improve_tile_unpressed_img, improve_tile_x, improve_tile_y, 0, scale_factor, scale_factor)
        else
            love.graphics.draw(improve_tile_pressed_img, improve_tile_x, improve_tile_y, 0, scale_factor, scale_factor)
        end
    end
end

-- This function starts drawing the menu on a certain side.
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
