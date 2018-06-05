TurnManager = {}

RED = true
BLUE = false

TurnManager.inSetup = false
TurnManager.currentPlayerTurn = RED

function TurnManager.load()
    --TurnManager.inSetup = true
end

-- This function opens the menu.
function TurnManager.openMenu(tile_x, tile_y)
    --TODO: this.
end

function TurnManager.update()
    if TurnManager.currentPlayerTurn then
        
    end
end

return TurnManager
