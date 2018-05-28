function love.load()
    print ("AHHHHHHHHHHHHHHHHHHHH!!!!!!")

    --this is a library that simulates classes in lua
    Object = require "classic"

    --everytime you generate a string of random numbers it'll be different
    math.randomseed(os.time())

    --setting up window and title
    love.window.setTitle("Farm Wars")
    love.window.maximize()
    love.graphics.setBackgroundColor(135, 206, 250, a)

    --this is so that the map is being constantly redrawn
    map_drawn = false

    --getting the screen dimensions and setting up how many tiles based on that
    screen_width, screen_height = love.graphics.getWidth(), love.graphics.getHeight()
    tiles_width, tiles_height = screen_width / 64, screen_height / 64

    --loading images
    fence_top = love.graphics.newImage("Fence_Top.png")
    fence_mid = love.graphics.newImage("Fence_Mid.png")
    fence_bottom = love.graphics.newImage("Fence_Bottom.png")
    fence_single = love.graphics.newImage("Fence_Single.png")

    grass = love.graphics.newImage("Grass.png")
    apple_tree = love.graphics.newImage("Apple_Tree.png")
    wheat = love.graphics.newImage("Wheat.png")

    --list of all tiles on the map
    map_list = {}
end

--just so that I can regenearte the map
function love.update(dt)
    if love.keyboard.isDown("r") then
        --removes all tiles
        for i, v in ipairs(map_list) do
            table.remove(map_list, i)
        end

        --redraws the map
        map_drawn = false
    end
end

function DrawMap()

    if map_drawn == false then
        --makes a multi dimensional array of [width][height]
        for i = 0, tiles_width do
            --places and array that will store a column of tiles
            table.insert(map_list, {})
            for j = 0, tiles_height do

                random_number = love.math.random(1, 41)
                --randomly generates a number to decide if tile is grass or not
                if random_number <= 40 then
                    table.insert(map_list[i + 1], "grass")
                else
                    table.insert(map_list[i + 1], "apple")
                end

                --if the tiles reach the screen boundary, stop drawing the map
                if i == math.floor(tiles_width + 0.5) - 1 and j == math.floor(tiles_height+0.5) - 1 then
                    map_drawn = true
                end
            end
        end
    end

    --goes through every column
    for i, v in ipairs(map_list) do
        for j, k in ipairs(map_list[i]) do

            --draws the respective image on the screen

            --places apple tree on top of grass
            if map_list[i][j] == "grass" then
                love.graphics.draw(grass, (i - 1) * 64, (j - 1) * 64, r, sx, sy, ox, oy, kx, ky)
            end

            if map_list[i][j] == "apple" then
                love.graphics.draw(grass, (i - 1) * 64, (j - 1) * 64, r, sx, sy, ox, oy, kx, ky)
                love.graphics.draw(apple_tree, (i - 1) * 64, (j - 1) * 64, r, sx, sy, ox, oy, kx, ky)
            end
        end
    end
end

function love.draw()
    --draws the map
    DrawMap()
    love.graphics.draw(fence_single, 0, 0, r, sx, sy, ox, oy, kx, ky)

end
