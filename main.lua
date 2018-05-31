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

function love.draw()
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.draw()
    else
        -- Draw the background.
        love.graphics.draw(bg_game, 0, 0, r, bg_scale, bg_scale)

        -- Draws the map
        drawMap()
        love.graphics.draw(fence_single, 0, 0, 0, scale_factor, scale_factor, ox, oy, kx, ky)
    end
end

function love.update()
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.update()
    else

    end
end
