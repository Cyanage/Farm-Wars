UI = {}

-- load images
function UI.init()
    red_turn_img = love.graphics.newImage("resc/images/red_turn_bar.png")
    blue_turn_img = love.graphics.newImage("resc/images/blue_turn_bar.png")
end

function UI.draw()
    local x_pos = pos_centered.x
    local y_pos = pos_centered.y - tile_size

    if TurnManager.currentPlayerTurn == RED then
        turn_img = red_turn_img
    else
        turn_img = blue_turn_img
    end

    love.graphics.draw(turn_img, x_pos, y_pos, 0, scale_factor, scale_factor)
end

function UI.update()

end


return UI
