-- Global and Constant variables.
    MAX_TILES = {x=16, y=9}  -- The prefered amount of tiles to be drawn.

function love.load()
    -- This is a library that simulates classes in lua (even though lua allready has classes, *cough cough*)
    Object = require "classic"

    -- Set up the window.
    love.window.setTitle("Farm Wars")
    love.window.maximize()

    -- Modules and classes are loaded here.
    menu = require "menu"
    button = require "button"
    game = require "game"

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

    -- TODO: add a nice image here.
    bg_game = love.graphics.newImage("resc/images/Background.png")
    bg_scale = love.graphics.getWidth() / bg_game:getWidth()

    -- Init modules
    menu.init()
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
    print (screen_width, screen_height)
end

function love.mousepressed(mouse_x, mouse_y, mouse_button)
    -- Check what scene is active.
    if menu.isActive() == true then
        -- Do nothing?
    else
        if mouse_button == 1 then
            game.checkFence(mouse_x, mouse_y)
        end
    end
end

function love.draw()
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.draw()
    else
        Game.draw()
    end
  end

function love.update()
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.update()
    else
        game.update()
    end
end
