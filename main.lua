local STATE = require 'menu'

function load_state(new_state,...)
    if STATE.exit then STATE.exit() end
    STATE = new_state
    if STATE.load then STATE.load(...) end
end

function love.load()
    if STATE.load then STATE.load() end
end

function love.update(dt)
    if STATE.update then STATE.update(dt) end
end

function love.draw()
	love.graphics.setNewFont(8)
    love.graphics.scale(4, 4)
    love.graphics.setColor(255,255,255)
    if STATE.draw then STATE.draw() end
end

function love.keypressed(...)
    if STATE.keypressed then STATE.keypressed(...) end
end

function love.keyreleased(...)
    if STATE.keyreleased then STATE.keyreleased(...) end
end