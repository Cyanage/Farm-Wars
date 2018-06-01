Game = {}

function Game.init()

end

function love.mousepressed(mouse_x, mouse_y, mouse_button)
  --if it's mouse left click
  if mouse_button == 1 then
    for i, v in ipairs(g_map_list) do
      for j, p in ipairs(g_map_list[i]) do

        tile_x = ( (i - 1) * tile_size ) + pos_centered.x
        tile_y = ( (j - 1) * tile_size ) + pos_centered.y

        if mouse_x >= tile_x and mouse_x <= tile_x + (64 * scale_factor) and mouse_y >= tile_y and mouse_y <= tile_y + (64 * scale_factor) then
          table.insert(fence_list_x, tile_x)
          table.insert(fence_list_y, tile_y)
        end
      end
    end
  end
end

function drawMap()
    -- Loops through every column.
    for i, p in ipairs(g_map_list) do
        for j, p2 in ipairs(g_map_list[i]) do

            tile_x = ( (i - 1) * tile_size ) + pos_centered.x
            tile_y = ( (j - 1) * tile_size ) + pos_centered.y

            -- Places apple tree on top of grass.
            if g_map_list[i][j] == 0 then
                love.graphics.draw(grass, tile_x, tile_y, 0, scale_factor, scale_factor, ox, oy, kx, ky)
            end

            if g_map_list[i][j] == 1 then
                love.graphics.draw(grass, tile_x, tile_y, 0, scale_factor, scale_factor, ox, oy, kx, ky)
                love.graphics.draw(apple_tree, tile_x, tile_y, 0, scale_factor, scale_factor, ox, oy, kx, ky)
            end
        end
    end
end

function Game.draw()
    -- Draw the background.
    love.graphics.setColor(1, 1, 1, 1)  -- Colour
    love.graphics.draw(bg_game, 0, 0, r, bg_scale, bg_scale)

    -- Draws the map
    drawMap()

    --loops through every item in the list to check if there's a fence tile
    --above or below it and if there isn't then it draws a single, but it
    --never stops drawing singles

    for i, v in ipairs(fence_list_x) do
        for j, p in ipairs(fence_list_y) do

            if fence_list_y[j] == (fence_list_y[i] - (64*scale_factor)) and fence_list_x[j] == fence_list_x[i] then
                love.graphics.draw(fence_bottom, fence_list_x[i], fence_list_y[i], 0, scale_factor, scale_factor, ox, oy, kx, ky)
            elseif fence_list_y[j] == (fence_list_y[i] + (64*scale_factor)) and fence_list_x[j] == fence_list_x[i] then
                love.graphics.draw(fence_top, fence_list_x[i], fence_list_y[i], 0, scale_factor, scale_factor, ox, oy, kx, ky)
            else
                love.graphics.draw(fence_single, fence_list_x[i], fence_list_y[i], 0, scale_factor, scale_factor, ox, oy, kx, ky)
            end
        end
    end

    love.graphics.draw(fence_single, 0 + pos_centered.x, 0 + pos_centered.y, 0, scale_factor, scale_factor, ox, oy, kx, ky)
end

function Game.update()

end


return Game
