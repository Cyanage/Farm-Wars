TurnManager = {}

RED = true
BLUE = false

TurnManager.inSetup = false
TurnManager.currentAction = 0
TurnManager.currentPlayerTurn = RED

function TurnManager.load()
    --TurnManager.inSetup = true
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
        if TurnManager.currentAction == _checkTileClick then
            _checkTileClick()
        end
    else
        if TurnManager.currentAction == _checkTileClick then
            _checkTileClick()
        end
    end
end

function _checkTileClick()
    -- TODO: Make sure the mouse is on *any* tile.
    if love.mouse.isDown(0) == true and love.mouse.getX() > pos_centered.x then

    end
end

return TurnManager
