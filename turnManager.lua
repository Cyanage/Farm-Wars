TurnManager = {}

RED = true
BLUE = false

TurnManager.inSetup = false
TurnManager.currentAction = 0
TurnManager.currentPlayerTurn = RED

local mouseTrigger = false
local mouseUp = false

function TurnManager.load()
    --TurnManager.inSetup = true
    love.timer.sleep( 0.25 )
end

-- Player colour is a bool
function TurnManager.setPlayerTurn(playerColour)
    if playerColour == RED then
        --TurnManager.inSetup = true
    else
        --TurnManager.inSetup = true
    end
end

-- This function opens the menu.
function TurnManager.openMenu(tile_x, tile_y)
    --TODO: this.
end

function TurnManager.update()
    if TurnManager.currentPlayerTurn == RED then
        if TurnManager.currentAction == 0 then
            _checkTileClick()
        end
    else
        if TurnManager.currentAction == 0 then
            _checkTileClick()
        end
    end
end

function _checkTileClick()
    -- Makes sure the mouse is on a tile.
    if mouseUp == false and love.mouse.isDown(1) == true and love.mouse.getX() > pos_centered.x and love.mouse.getX() < pos_centered.x + (MAX_TILES.x*tile_size) and love.mouse.getY() > pos_centered.y and love.mouse.getY() < pos_centered.y + (MAX_TILES.y*tile_size) then
        mouseTrigger = true
        mouseUp = true
        print "start"
    end

    if mouseTrigger == true then
        x_tile = math.floor((love.mouse.getX() - pos_centered.x)/tile_size)
        y_tile = math.floor((love.mouse.getY() - pos_centered.y)/tile_size)

        print ('x', x_tile, 'y', y_tile)

        if x_tile > math.floor(MAX_TILES.x/2)-1 then
            UI.openMenu(LEFT)
        else
            UI.openMenu(RIGHT)
        end

        mouseTrigger = false

        print "trigger"
    end

    if mouseUp == true and love.mouse.isDown(1) == false then
        mouseUp = false
        print "done"
    end
end

return TurnManager
