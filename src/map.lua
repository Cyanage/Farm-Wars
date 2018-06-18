Map = {}

map_matrix = {}  -- Matrix of all tiles on the map.

-- This function loads the map.
function Map.load()
    math.randomseed(os.time())  -- Reset the randomizer seed.
    createMap()
    barnImg = love.graphics.newImage("resc/images/Barn.png")
end

-- Creates a multi dimensional array of [width][height], stored in map_matrix.
function createMap()
    for i = 0, MAX_TILES.x-1 do  -- Width
        -- Creates an array that will store a column of tiles
        local column = {}

        for j = 0, MAX_TILES.y-1 do  -- Height
            -- Assign the tile value at this position in the matrix.
            local tileVal = getRandomInitTileValue()
            table.insert(column, tileVal)
        end

        table.insert(map_matrix, column)
    end
end

-- This function generates a random amount of starting trees & tiles.
function getRandomInitTileValue()
    -- Randomly generates a number to decide if tile is grass or not.
    local random_number = love.math.random(1, 43)
    if random_number <= 40 then
        return 0
    else
        return 5
    end
end

-- This function gets the value of a certain tile.
function Map.getTile(x, y)
    return map_matrix[x][y]
end

-- This function sets the value of a certain tile.
function Map.setTile(x, y, value)
    map_matrix[x][y] = value
end

-- This function returns true if the tile has a fence on it.
function Map.isTileFence(x, y)
    if map_matrix[x][y] >= 30 and map_matrix[x][y] < 60 or map_matrix[x][y] >= 30+60 and map_matrix[x][y] < 60+60 then
        return true
    else
        return false
    end
end

-- This function returns true if the tile has a fence on it.
function Map.isColour(colour, x, y)
    if colour == RED then
        if map_matrix[x][y] >= 10 and map_matrix[x][y] < 20 or map_matrix[x][y] >= 40 and map_matrix[x][y] < 50 or map_matrix[x][y] >= 40+30 and map_matrix[x][y] < 50+30 or map_matrix[x][y] >= 40+60 and map_matrix[x][y] < 50+60 then
            return true
        end
    else
        if map_matrix[x][y] >= 20 and map_matrix[x][y] < 30 or map_matrix[x][y] >= 50 and map_matrix[x][y] < 60 or map_matrix[x][y] >= 50+30 and map_matrix[x][y] < 60+30 or map_matrix[x][y] >= 50+60 and map_matrix[x][y] < 60+60 then
            return true
        end
    end
    return false
end

-- This function returns true if the tile has a fence on it.
function Map.isSelected(x, y)
    if map_matrix[x][y] >= 60 then
        return true
    else
        return false
    end
end

-- This function draws the map to the screen.
local function drawMap()
    love.graphics.setColor(1, 1, 1, 1)  -- Set a white colour mod.

    -- Loops through every column.
    for x, p in ipairs(map_matrix) do
        for y, p2 in ipairs(map_matrix[x]) do
            -- Find the position for the tile.
            local tile_x = ( (x - 1) * tile_size ) + pos_centered.x
            local tile_y = ( (y - 1) * tile_size ) + pos_centered.y

            -- Draw tile at x,y  ('% 10' means that 16 and 6 are considered the same tile, tree_used)
            if map_matrix[x][y] % 10 == 0 then
                love.graphics.draw(grass, tile_x, tile_y, 0, scale_factor, scale_factor)
            elseif map_matrix[x][y] % 10 == 1 then
                love.graphics.draw(wheat1, tile_x, tile_y, 0, scale_factor, scale_factor)
            elseif map_matrix[x][y] % 10 == 2 then
                love.graphics.draw(wheat2, tile_x, tile_y, 0, scale_factor, scale_factor)
            elseif map_matrix[x][y] % 10 == 3 then
                love.graphics.draw(wheat3, tile_x, tile_y, 0, scale_factor, scale_factor)
            elseif map_matrix[x][y] % 10 == 4 then
                love.graphics.draw(destroyed, tile_x, tile_y, 0, scale_factor, scale_factor)
            elseif map_matrix[x][y] % 10 == 5 then  -- Draws an apple tree and grass.
                love.graphics.draw(grass, tile_x, tile_y, 0, scale_factor, scale_factor)
                love.graphics.setColor(1, 1, 1, 1)  -- Tree has a white colour mod (normal)
                love.graphics.draw(tree, tile_x, tile_y, 0, scale_factor, scale_factor)
            elseif map_matrix[x][y] % 10 == 6 then  -- Draws an apple tree and grass.
                love.graphics.draw(grass, tile_x, tile_y, 0, scale_factor, scale_factor)
                love.graphics.setColor(1, 1, 1, 1)  -- Tree has a white colour mod (normal)
                love.graphics.draw(tree_used, tile_x, tile_y, 0, scale_factor, scale_factor)
            end

            -- Check if tile is claimed.
            if map_matrix[x][y] >= 10 and map_matrix[x][y] < 20 or map_matrix[x][y] >= 40 and map_matrix[x][y] < 50 or map_matrix[x][y] >= 40+30 and map_matrix[x][y] < 50+30 or map_matrix[x][y] >= 40+60 and map_matrix[x][y] < 50+60 then
                love.graphics.draw(red_claimed, tile_x, tile_y, 0, scale_factor, scale_factor)
            elseif map_matrix[x][y] >= 20 and map_matrix[x][y] < 30 or map_matrix[x][y] >= 50 and map_matrix[x][y] < 60 or map_matrix[x][y] >= 50+30 and map_matrix[x][y] < 60+30 or map_matrix[x][y] >= 50+60 and map_matrix[x][y] < 60+60 then
                love.graphics.draw(blue_claimed, tile_x, tile_y, 0, scale_factor, scale_factor)
            end

            -- Check if a fence needs to be drawn over the tile.
            if map_matrix[x][y] >= 30 and map_matrix[x][y] < 60 or map_matrix[x][y] >= 30+60 and map_matrix[x][y] < 60+60 then
                love.graphics.setColor(1, 1, 1, 1)  -- Tree has a white colour mod (normal)
                love.graphics.draw(fence_single, tile_x, tile_y, 0, scale_factor, scale_factor)
            end

            -- Check if the tile needs to have the 'selected' image on top of it.
            if map_matrix[x][y] >= 60 then
                love.graphics.setColor(1, 1, 1, 1)  -- Tree has a white colour mod (normal)
                love.graphics.draw(selected, tile_x, tile_y, 0, scale_factor, scale_factor)
            end
        end
    end
end

function Map.draw()
    drawMap()  -- Draws the map
    love.graphics.draw(barnImg, (1*scale_factor) + pos_centered.x, (3*scale_factor) + pos_centered.y, r, sx, sy, ox, oy, kx, ky)
end

return Map
