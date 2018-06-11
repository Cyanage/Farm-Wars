Game = {}

function Game.load()
    map.load()  -- Load the map.
    turnManager.load()
    gameDone = false  --whether the game is done or not
    finalText = {"w", "l"}  --stores the name of the winner and loser
end

-- This function tries to make a tile into a fence.
function Game.setFence(x_index, y_index)
    tile_x = x_index + 1
    tile_y = y_index + 1

    if tile_x > 0 and tile_x <= MAX_TILES.x and tile_y > 0 and tile_y <= MAX_TILES.y then
        if map.isTileFence(tile_x, tile_y) == false then
            map.setTile(tile_x, tile_y, map.getTile(tile_x, tile_y) + 30)  -- Make tile a fence.
        else
            print("SOMeTHING TRIED TO SET A TILE THAT WAS A FENCE WAS TO BE A FENCE.")
        end
    end
end

-- This function tries to make a tile into a fence.
function Game.setMassive(x_index, y_index, is_massive)
    tile_x = x_index + 1
    tile_y = y_index + 1

    if is_massive == true then
        if tile_x > 0 and tile_x <= MAX_TILES.x and tile_y > 0 and tile_y <= MAX_TILES.y then
            if map.isMassive(tile_x, tile_y) == false then
                map.setTile(tile_x, tile_y, map.getTile(tile_x, tile_y) + 60)  -- Make tile a fence.
            else
                print("ATTEMPT TO SET A TILE TO BE THE SAME TILE AS ITSELF.")
            end
        end
    else
        if tile_x > 0 and tile_x <= MAX_TILES.x and tile_y > 0 and tile_y <= MAX_TILES.y then
            if map.isMassive(tile_x, tile_y) == true then
                map.setTile(tile_x, tile_y, map.getTile(tile_x, tile_y) - 60)  -- Make tile a fence.
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
    if gameDone == true then
      love.graphics.print(finalText[1] .. " has defeated " .. finalText[2], 100, 100)
    end
end

function Game.update()
    turnManager.update()
    ui.update()
end

--when one player wins this is called
function Game.finish(winner, loser) -- gets name of winner and loser

  gameDone = true
  finalText[1] = winner --gets the name of the winner
  finalText[2] = loser  --gets the name of the loser
end

return Game
