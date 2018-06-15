Game = {}

-- Globals
gGameDone = false  --whether the game is done or not
gResults = { winner="winner", loser="loser" }  -- Holds the name of the winner and loser

function Game.load()
    map.load()  -- Load the map.
    turnManager.load()
end

-- This function tries to make a tile into a fence.
function Game.setFence(x_index, y_index)
    tile_x = x_index + 1
    tile_y = y_index + 1

    if tile_x > 0 and tile_x <= MAX_TILES.x and tile_y > 0 and tile_y <= MAX_TILES.y then
        if map.isTileFence(tile_x, tile_y) == false then
            map.setTile(tile_x, tile_y, map.getTile(tile_x, tile_y) + 30)  -- Make tile a fence.
        else
            print("SOMETHING TRIED TO SET A TILE THAT WAS A FENCE WAS TO BE A FENCE.")
        end
    end
end

-- This function tries to make a tile to be selected.
function Game.setSelectedTile(xIndex, yIndex, isSelected)
    xTile = xIndex + 1
    yTile = yIndex + 1

    if isSelected == true then
        if xTile > 0 and xTile <= MAX_TILES.x and yTile > 0 and yTile <= MAX_TILES.y then
            if map.isSelected(xTile, yTile) == false then
                map.setTile(xTile, yTile, map.getTile(xTile, yTile) + 60)  -- Make tile a fence.
            else
                print("ATTEMPT TO SET A TILE TO BE THE SAME TILE AS ITSELF.")
            end
        end
    else
        if xTile > 0 and xTile <= MAX_TILES.x and yTile > 0 and yTile <= MAX_TILES.y then
            if map.isSelected(xTile, yTile) == true then
                map.setTile(xTile, yTile, map.getTile(xTile, yTile) - 60)  -- Make tile a fence.
            else
                print("ATTEMPT TO SET A TILE TO BE THE SAME TILE AS ITSELF.")
            end
        end
    end
end

-- Draws the background and the tiles.
function Game.draw()
    -- Draw the background.
    love.graphics.setColor(1, 1, 1, 1)  -- Colour
    love.graphics.draw(bg_game, 0, 0, r, bg_scale, bg_scale)

    map.draw()  -- This draws all the tiles to the screen.
    ui.draw()

    --displays that the winner has beaten the loser overtop of map and ui
    if gGameDone == true then
      love.graphics.print(gResults.winner .. " has defeated " .. gResults.loser, gPosition.x, gPosition.y)
    end
end

function Game.update(dt)
    turnManager.update(dt)
    ui.update()
end

-- When one player wins this is called
function Game.finish(winner, loser)  -- This function gets the name of the winner and loser.
    gGameDone = true
    gResults.winner = winner  -- Gets the name of the winner
    gResults.loser = loser  -- Gets the name of the loser
end

return Game
