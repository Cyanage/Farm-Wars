-- Global and Constant variables.
MAX_TILES = {x=16, y=8}  -- The prefered amount of tiles to be drawn.

function love.load()
    -- Set up the window.
    love.window.setTitle("Farm Wars")
    love.window.maximize()

    -- Modules and classes are loaded here.
    menu = require "src/menu"
    button = require "src/objects/button"
    game = require "src/game"
    map = require "src/map"
    money = require "src/objects/money"
    ui = require "src/ui"

    font = love.graphics.newFont(64)
    love.graphics.setFont(font)

    player_money = money:new()
    enemy_money = money:new()

    font_y = 63
    player_font_x = 280
    enemy_font_x = 1180

    --so that when enemy moey goes up, it doesn't just fly off to left
    has_gone_up = false
    has_gone_down = false

    turnManager = require "src/turnManager"

    -- Any initialization code goes after here:
    initScreen()  -- Initialize the tilemap and screen size.

    -- Load Images:
    fence_single = love.graphics.newImage("resc/images/tiles/Fence_Single_v2.png")
    barn = love.graphics.newImage("resc/images/Barn.png")
    selected = love.graphics.newImage("resc/images/image_pointers.png")

    grass = love.graphics.newImage("resc/images/tiles/GrassVer2.png")
    wheat1 = love.graphics.newImage("resc/images/tiles/Wheat1.png")
    wheat2 = love.graphics.newImage("resc/images/tiles/Wheat2.png")
    wheat3 = love.graphics.newImage("resc/images/tiles/Wheat3.png")
    destroyed = love.graphics.newImage("resc/images/tiles/Destroyed.png")
    tree = love.graphics.newImage("resc/images/tiles/Apple_Tree.png")
    tree_used = love.graphics.newImage("resc/images/tiles/Picked_Apple_Tree.png")

    -- Background Image for the game.
    bg_game = love.graphics.newImage("resc/images/nonPixelArt/Background.png")
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
        -- If player clicks, try to place a fence. (DEBUG: this)
        if mouse_button == 1 then
            --game.setFence(mouse_x, mouse_y)
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

    player_money:draw(player_font_x, font_y)
    enemy_money:draw(enemy_font_x, font_y)

  end

function love.update(dt)

    if love.keyboard.isDown("a") then
      game.finish("Bill Cosby", "You")
    end

    if enemy_money:get_current_money() >= 100 and has_gone_up == false or enemy_money:get_current_money() <= -100 and has_gone_up == false then
        enemy_font_x = enemy_font_x - 40
        has_gone_up = true
        print (tostring(has_gone_up))
    end

    if enemy_money:get_current_money() < 0  and has_gone_down == false then
        enemy_font_x = enemy_font_x - 20
        has_gone_down = true
    end

    -- Check what scene is active.
    if menu.isActive() == true then
        menu.update()
    else
        game.update(dt)
    end
end
