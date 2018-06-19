TurnManager = {}

RED = true
BLUE = false

TurnManager.inSetup = false
TurnManager.currentAction = 0
TurnManager.currentPlayerTurn = RED

money = require "src/objects/money"  -- So that money can go up each turn
farmer = require "src/objects/farmer"

player_money = money:new()
enemy_money = money:new()

buy_fence_is_pressed = false
end_turn_is_pressed = false
claim_tile_is_pressed = false

local endTurnWaitTime = 0  -- The time to wait before doing any new logic / ending the turn.
local doAction = false
local mouseUp = false
local mouseDownAction = false

local clickedTile = {x=0, y=0}

local farmerList = {} -- Add farmer:new(pos_x, pos_y) to the table to add a farmer into game

function TurnManager.load()
    --TurnManager.inSetup = true
    love.timer.sleep( 0.25 )
end

-- Player colour is a bool
function TurnManager.setPlayerTurn()
    UI.closeMenu()  -- Close the menu before the units moves.
    --TurnManager.inSetup = true
    TurnManager.currentAction = 0  -- Set next player's action (select a tile action)

    if TurnManager.currentPlayerTurn == RED then
          player_money:update()
    elseif TurnManager.currentPlayerTurn == BLUE then
          enemy_money:update()
    end

    TurnManager.currentPlayerTurn = not TurnManager.currentPlayerTurn

end

local function _checkTileClick()
    -- Makes sure the mouse is on the game board.
    if mouseUp == false and love.mouse.isDown(1) == true and love.mouse.getX() > pos_centered.x and love.mouse.getX() < pos_centered.x + (MAX_TILES.x*tile_size) and love.mouse.getY() > pos_centered.y and love.mouse.getY() < pos_centered.y + (MAX_TILES.y*tile_size) then
        doAction = true
        mouseUp = true
    end

    if doAction == true then
        x_tile = math.floor((love.mouse.getX() - pos_centered.x)/tile_size)
        y_tile = math.floor((love.mouse.getY() - pos_centered.y)/tile_size)

        -- Check what side of the screen the mouse is to open the menu.
        if x_tile > math.floor(MAX_TILES.x/2)-1 then
            UI.openMenu(LEFT)
        else
            UI.openMenu(RIGHT)
        end

        clickedTile = {x=x_tile, y=y_tile}  -- Save the position of the clicked tile.
        game.setSelectedTile(x_tile, y_tile, true)  -- Make the clicked tile larger to show it is pressed.

        TurnManager.currentAction = 1  -- Next time the mouse is pressed this variable tells the code to check if a button is pressed.

        doAction = false
    end

    if mouseUp == true and love.mouse.isDown(1) == false then
        mouseUp = false
    end
end

local function _checkButtonUpActions(mouse_x_pos, mouse_y_pos)
    -- Get width and height of all the buttons
    buy_fence_width = buy_fence_unpressed_img:getWidth() * scale_factor
    buy_fence_height = buy_fence_unpressed_img:getHeight() * scale_factor
    end_turn_width = end_turn_unpressed_img:getWidth() * scale_factor
    end_turn_height = end_turn_unpressed_img:getHeight() * scale_factor
    claim_tile_width = claim_tile_unpressed_img:getWidth() * scale_factor
    claim_tile_height = claim_tile_unpressed_img:getHeight() * scale_factor
    improve_tile_width = improve_tile_unpressed_img:getWidth() * scale_factor
    improve_tile_height = improve_tile_unpressed_img:getHeight() * scale_factor

    claim_tile_empty_width = 56 * scale_factor
    claim_tile_empty_height = claim_tile_empty_width

    -- Change all button images to be unpressed.
    buy_fence_is_pressed = false
    end_turn_is_pressed = false
    claim_tile_is_pressed = false
    improve_tile_is_pressed = false

    print (map.getTile(clickedTile.x+1, clickedTile.y+1), "THISSS!!!!!!")

    -- Check if the mouse is over the button.
    if mouse_x_pos > buy_fence_x and mouse_x_pos < buy_fence_x + buy_fence_width and mouse_y_pos > buy_fence_y and mouse_y_pos < buy_fence_y + buy_fence_height then
        print "clicked fence button"
        if map.isSelected(clickedTile.x+1, clickedTile.y+1) == true then
            if map.isTileFence(clickedTile.x+1, clickedTile.y+1) == false then
                if TurnManager.currentPlayerTurn == RED and clickedTile.x < MAX_TILES.x/2 or TurnManager.currentPlayerTurn == BLUE and clickedTile.x >= MAX_TILES.x/2 then
                    game.setFence(clickedTile.x, clickedTile.y)  -- Add a fence to the current tile.
                    game.setSelectedTile(clickedTile.x, clickedTile.y, false)  -- Make the active tile unselected again.

                    --money:add_money(-80)

                    -- Finds out which player bought the fence
                    if TurnManager.currentPlayerTurn == RED then
                        player_money:add_money_per_turn(-5) --adds -5 money per turn
                        print ("player bought quatuar defuar")
                    elseif TurnManager.currentPlayerTurn == BLUE then
                        enemy_money:add_money_per_turn(-5) --adds -5 money per turn
                        print ("enemy bought a fence")
                    end
                end
            end
        end

    elseif mouse_x_pos > end_turn_x and mouse_x_pos < end_turn_x + end_turn_width and mouse_y_pos > end_turn_y and mouse_y_pos < end_turn_y + end_turn_height then
        print "clicked end turn button"

        game.setSelectedTile(clickedTile.x, clickedTile.y, false)  -- Make the active tile unselected again.

        -- Wait 1/4 of a second until the ending of the current turn.  (menu is also closed on turn end)
        endTurnWaitTime = 0.25

    elseif (mouse_x_pos > claim_tile_x and mouse_x_pos < claim_tile_x + claim_tile_width and mouse_y_pos > claim_tile_y and mouse_y_pos < claim_tile_y + claim_tile_height) and (mouse_x_pos > claim_tile_x + claim_tile_empty_width or mouse_y_pos > claim_tile_y + claim_tile_empty_height) then
        print "clicked claim tile button"
        if map.isSelected(clickedTile.x+1, clickedTile.y+1) == true then
            if map.isColour(RED, clickedTile.x+1, clickedTile.y+1) == false and map.isColour(BLUE, clickedTile.x+1, clickedTile.y+1) == false then
                if TurnManager.currentPlayerTurn == RED and clickedTile.x < MAX_TILES.x/2 then
                    map.setTile( clickedTile.x+1, clickedTile.y+1, map.getTile(clickedTile.x+1, clickedTile.y+1) + 20 - 10*(bool_to_number(TurnManager.currentPlayerTurn)) )
                    game.setSelectedTile(clickedTile.x, clickedTile.y, false)  -- Make the active tile unselected again.
                elseif TurnManager.currentPlayerTurn == BLUE and clickedTile.x >= MAX_TILES.x/2 then
                    map.setTile( clickedTile.x+1, clickedTile.y+1, map.getTile(clickedTile.x+1, clickedTile.y+1) + 20 - 10*(bool_to_number(TurnManager.currentPlayerTurn)) )
                    game.setSelectedTile(clickedTile.x, clickedTile.y, false)  -- Make the active tile unselected again.
                end
            end
        end

    elseif mouse_x_pos > improve_tile_x and mouse_x_pos < improve_tile_x + improve_tile_width and mouse_y_pos > improve_tile_y and mouse_y_pos < improve_tile_y + improve_tile_height then
        print "improve_tile clicked up"
        if map.isSelected(clickedTile.x+1, clickedTile.y+1) == true then
            if TurnManager.currentPlayerTurn == RED and clickedTile.x < MAX_TILES.x/2 or TurnManager.currentPlayerTurn == BLUE and clickedTile.x >= MAX_TILES.x/2 then
                print ("0", map.getTile(clickedTile.x+1, clickedTile.y+1))
                if map.getTile(clickedTile.x+1, clickedTile.y+1) % 10 == 5 or map.getTile(clickedTile.x+1, clickedTile.y+1) % 10 == 0 or map.getTile(clickedTile.x+1, clickedTile.y+1) % 10 == 1 or map.getTile(clickedTile.x+1, clickedTile.y+1) % 10 == 2 then
                    print "1"
                    map.setTile( clickedTile.x+1, clickedTile.y+1, map.getTile(clickedTile.x+1, clickedTile.y+1) +1 )
                    game.setSelectedTile(clickedTile.x, clickedTile.y, false)  -- Make the active tile unselected again.
                end
            end
        end

    else
        print " no clicked button !!!!!!!!"
        --something
    end
end

local function _checkButtonDownActions(mouse_x_pos, mouse_y_pos)
    -- Get width and height of all the buttons
    buy_fence_width = buy_fence_unpressed_img:getWidth() * scale_factor
    buy_fence_height = buy_fence_unpressed_img:getHeight() * scale_factor
    end_turn_width = end_turn_unpressed_img:getWidth() * scale_factor
    end_turn_height = end_turn_unpressed_img:getHeight() * scale_factor
    claim_tile_width = claim_tile_unpressed_img:getWidth() * scale_factor
    claim_tile_height = claim_tile_unpressed_img:getHeight() * scale_factor
    improve_tile_width = improve_tile_unpressed_img:getWidth() * scale_factor
    improve_tile_height = improve_tile_unpressed_img:getHeight() * scale_factor

    claim_tile_empty_width = 56 * scale_factor
    claim_tile_empty_height = claim_tile_empty_width

    -- Check if the mouse is over the button.
    if mouse_x_pos > buy_fence_x and mouse_x_pos < buy_fence_x + buy_fence_width and mouse_y_pos > buy_fence_y and mouse_y_pos < buy_fence_y + buy_fence_height then
        print "clicked fence button down"
        buy_fence_is_pressed = true  -- Change the button image to being pressed.

    elseif mouse_x_pos > end_turn_x and mouse_x_pos < end_turn_x + end_turn_width and mouse_y_pos > end_turn_y and mouse_y_pos < end_turn_y + end_turn_height then
        print "clicked end turn button down"
        end_turn_is_pressed = true  -- Change the button image to being pressed.

    elseif (mouse_x_pos > claim_tile_x and mouse_x_pos < claim_tile_x + claim_tile_width and mouse_y_pos > claim_tile_y and mouse_y_pos < claim_tile_y + claim_tile_height) and (mouse_x_pos > claim_tile_x + claim_tile_empty_width or mouse_y_pos > claim_tile_y + claim_tile_empty_height) then
        print "clicked claim tile button down"
        claim_tile_is_pressed = true

    elseif mouse_x_pos > improve_tile_x and mouse_x_pos < improve_tile_x + improve_tile_width and mouse_y_pos > improve_tile_y and mouse_y_pos < improve_tile_y + improve_tile_height then
        print "clicked improve_tile button down"
        improve_tile_is_pressed = true  -- Change the button image to being pressed.

    else
        --print "no clicked button down !!!!!!!!"
    end
end

local function _checkMenuClick()
    -- Checks if the mouse is over the menu or not.  (this is the START CASE)  (when mouse goes up, button is activated.)
    if menuPosition == LEFT then
        if mouseUp == false and love.mouse.isDown(1) == true and love.mouse.getX() > pos_centered.x and love.mouse.getX() < menu_pane_img:getWidth()*scale_factor + pos_centered.x and love.mouse.getY() > pos_centered.y and love.mouse.getY() < pos_centered.y + (MAX_TILES.y*tile_size) then
            mouseUp = true
            mouseDownAction = true
        end

        if mouseUp == true and love.mouse.isDown(1) == false and love.mouse.getX() > pos_centered.x and love.mouse.getX() < menu_pane_img:getWidth()*scale_factor + pos_centered.x and love.mouse.getY() > pos_centered.y and love.mouse.getY() < pos_centered.y + (MAX_TILES.y*tile_size) then
            doAction = true
            mouseUp = false
        end
    else
        if mouseUp == false and love.mouse.isDown(1) == true and love.mouse.getX() > (tile_size*MAX_TILES.x) - menu_pane_img:getWidth()*scale_factor + pos_centered.x and love.mouse.getX() < (tile_size*MAX_TILES.x) + pos_centered.x and love.mouse.getY() > pos_centered.y and love.mouse.getY() < pos_centered.y + (MAX_TILES.y*tile_size) then
            mouseUp = true
            mouseDownAction = true
        end

        if mouseUp == true and love.mouse.isDown(1) == false and love.mouse.getX() > (tile_size*MAX_TILES.x) - menu_pane_img:getWidth()*scale_factor + pos_centered.x and love.mouse.getX() < (tile_size*MAX_TILES.x) + pos_centered.x and love.mouse.getY() > pos_centered.y and love.mouse.getY() < pos_centered.y + (MAX_TILES.y*tile_size) then
            doAction = true
            mouseUp = false
        end
    end

    -- ACTION  (Check if the mouse was clicked over a button)
    if doAction == false and mouseUp == true and mouseDownAction == true then
        mouse_x_pos = love.mouse.getX()
        mouse_y_pos = love.mouse.getY()

        _checkButtonDownActions(mouse_x_pos, mouse_y_pos)  -- Check if the mouse is over the button.

        doAction = false
        mouseDownAction = false

    elseif doAction == true then
        mouse_x_pos = love.mouse.getX()
        mouse_y_pos = love.mouse.getY()

        _checkButtonUpActions(mouse_x_pos, mouse_y_pos)  -- Check if the mouse is over the button.

        doAction = false
    end
end

function TurnManager.update(dt)
    -- Only update logic if the timer is done
    if endTurnWaitTime > 0 then
        endTurnWaitTime = endTurnWaitTime - dt

        -- This is called once per wait.
        if endTurnWaitTime <= 0 then
            TurnManager.setPlayerTurn()  -- Set to the other player's turn
        end
    else
        if TurnManager.currentPlayerTurn == RED then
            if TurnManager.currentAction == 0 then
                _checkTileClick()  -- Menu has not been opened.
            elseif TurnManager.currentAction == 1 then
                _checkMenuClick()  -- Menu has been opened.
            end
        else
            if TurnManager.currentAction == 0 then
                _checkTileClick()  -- Menu has not been opened.
            elseif TurnManager.currentAction == 1 then
                _checkMenuClick()  -- Menu has been opened.
            end
        end
    end
end

function TurnManager.farmers()
  return farmerList
end

return TurnManager
