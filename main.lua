-- Global and Constant variables.
    g_map_list = {}  -- List of all tiles on the map.
    MAX_TILES = {x=16, y=9}  -- The prefered amount of tiles to be drawn.

function love.load()
    -- This is a library that simulates classes in lua (even though lua allready has classes, *cough cough*)
    Object = require "classic"

    -- Set up the window.
    love.window.setTitle("Farm Wars")
    love.window.maximize()
    love.graphics.setBackgroundColor(0, 0, 0, 1)

    -- Modules and classes are loaded here.
    menu = require "menu"

    -- Any initialization code goes after here.
    math.randomseed(os.time())  -- Set the randomizer seed.
    initScreen()  -- Initialize the tilemap and screen size.

    -- Load Images.
    fence_top = love.graphics.newImage("resc/images/Fence_Top.png")
    fence_mid = love.graphics.newImage("resc/images/Fence_Mid.png")
    fence_bottom = love.graphics.newImage("resc/images/Fence_Bottom.png")
    fence_single = love.graphics.newImage("resc/images/Fence_Single.png")
    grass = love.graphics.newImage("resc/images/Grass.png")
    apple_tree = love.graphics.newImage("resc/images/Apple_Tree.png")
    wheat = love.graphics.newImage("resc/images/Wheat.png")

    fence_list_x = {}
    fence_list_y = {}
    draw_fence = false

    --temp
    bg_game = love.graphics.newImage("resc/images/mountains.png")
    bg_scale = love.graphics.getWidth() / bg_game:getWidth()

    -- Init modules
    menu.load()
end

function initScreen()
    -- Init screen dimension variables.
    screen_width, screen_height = love.graphics.getWidth(), love.graphics.getHeight()
    tile_size = math.floor( (screen_width / MAX_TILES.x) + 0.5 )
    scale_factor = tile_size / 64

    while (MAX_TILES.y) * scale_factor * 64 > screen_height do
        tile_size = (scale_factor * 64) - 16
        scale_factor = tile_size / 64
        print (scale_factor)
    end

    -- The top left corner of the tile map.
    pos_centered = { x=(screen_width - ((MAX_TILES.x) * scale_factor * 64))/2, y=(screen_height - ((MAX_TILES.y) * scale_factor * 64))/2 }
    print (pos_centered.x)

    -- Makes a multi dimensional array of [width][height]
    for i = 0, MAX_TILES.x-1 do  -- tiles_width
        -- Creates an array that will store a column of tiles
        column = {}

        for j = 0, MAX_TILES.y-1 do  -- tiles_height
            -- Randomly generates a number to decide if tile is grass or not.
            random_number = love.math.random(1, 41)
            if random_number <= 40 then
                table.insert(column, 0)
            else
                table.insert(column, 1)
            end
        end

        table.insert(g_map_list, column)
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

function love.draw()
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.draw()
    else
        -- Draw the background.
        love.graphics.draw(bg_game, 0, 0, r, bg_scale, bg_scale)

        -- Draws the map
        drawMap()

        --loops through every item in the list to check if there's a fence tile
        --above or below it and if there isn't then it draws a single, but it
        --never stops drawing singles

        for i, v in ipairs(fence_list_x) do
          for j, p in ipairs(fence_list_y) do

            if fence_list_y[j] == (fence_list_y[i] - (64*scale_factor)) and fence_list_x[j] == fence_list_x[i] then
              print("fence bottom")
              love.graphics.draw(fence_bottom, fence_list_x[i], fence_list_y[i], 0, scale_factor, scale_factor, ox, oy, kx, ky)
            elseif fence_list_y[j] == (fence_list_y[i] + (64*scale_factor)) and fence_list_x[j] == fence_list_x[i] then
              print ("fence top")
              love.graphics.draw(fence_top, fence_list_x[i], fence_list_y[i], 0, scale_factor, scale_factor, ox, oy, kx, ky)
            else
              print("fence single")
              love.graphics.draw(fence_single, fence_list_x[i], fence_list_y[i], 0, scale_factor, scale_factor, ox, oy, kx, ky)
            end
          end
        end
=======
        love.graphics.draw(fence_single, 0 + pos_centered.x, 0 + pos_centered.y, 0, scale_factor, scale_factor, ox, oy, kx, ky)
>>>>>>> 46c236db0b181bfee3f068f03a03c7db89b4afab
    end
  end

function love.update()
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.update()
    else

    end
end
