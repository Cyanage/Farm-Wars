-- Global and Constant variables.
    MAX_TILES = {x=16, y=8}  -- The prefered amount of tiles to be drawn.

function love.load()
    -- Set up the window.
    love.window.setTitle("Farm Wars")
    love.window.maximize()

    -- Modules and classes are loaded here.
    menu = require "menu"
    button = require "button"
    game = require "game"
    map = require "map"
    money = require "money"
    ui = require "ui"

    player_money = money:new()

    turnManager = require "turnManager"

    -- Any initialization code goes after here:
    initScreen()  -- Initialize the tilemap and screen size.

    -- Load Images:
    fence_top = love.graphics.newImage("resc/images/Fence_Top.png")
    fence_mid = love.graphics.newImage("resc/images/Fence_Mid.png")
    fence_bottom = love.graphics.newImage("resc/images/Fence_Bottom.png")
    fence_single = love.graphics.newImage("resc/images/Fence_Single_v2.png")
    barn = love.graphics.newImage("resc/images/Barn.png")

    grass = love.graphics.newImage("resc/images/GrassVer2.png")
    wheat1 = love.graphics.newImage("resc/images/Wheat1.png")
    wheat2 = love.graphics.newImage("resc/images/Wheat2.png")
    wheat3 = love.graphics.newImage("resc/images/Wheat3.png")
    destroyed = love.graphics.newImage("resc/images/Destroyed.png")
    tree = love.graphics.newImage("resc/images/Apple_Tree.png")
    tree_used = love.graphics.newImage("resc/images/Picked_Apple_Tree.png")

    -- Background Image for the game.
    bg_game = love.graphics.newImage("resc/images/Background.png")
    bg_scale = love.graphics.getWidth() / bg_game:getWidth()

    -- Init modules
    menu.init()
    ui.init()
end

function initScreen()
    -- Init screen dimension variables.
    screen_width, screen_height = love.graphics.getWidth(), love.graphics.getHeight()
    tile_size = math.floor( (screen_width / MAX_TILES.x) / 16 ) * 16
    scale_factor = tile_size / 64

    --print ("init tile size ", tile_size)

    while (MAX_TILES.y+1) * scale_factor * 64 > screen_height do
        --tile_size = (scale_factor * 64) - 16
        tile_size = tile_size - 16
        scale_factor = tile_size / 64
    end

    --print ("real tile size ", tile_size)

    -- The top left corner of the tile map.
    pos_centered = { x=(screen_width - ((MAX_TILES.x) * scale_factor * 64))/2, y=((screen_height - ((MAX_TILES.y+1) * scale_factor * 64))/2)+tile_size }
    --print ("screen w/h ", screen_width, screen_height)
end

function love.mousepressed(mouse_x, mouse_y, mouse_button)
    -- Check what scene is active.
    if menu.isActive() == true then
        -- Do nothing?
    else
        -- If player clicks, try to place a fence.
        if mouse_button == 1 then
            game.setFence(mouse_x, mouse_y)
        end
    end
end

function love.draw()
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.draw()
    else
        game.draw()
    end
  end

function love.update()
    --adds current money per turn every second
    player_money:update()
    print (player_money:get_current_money())
    
    -- Check what scene is active.
    if menu.isActive() == true then
        menu.update()
    else
        game.update()
    end
end
