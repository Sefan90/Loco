local gui = require 'gui'
local menu = {}

function menu.load()
	text = {"Play","Options","Exit"}
	selected = 1
end

function menu.update(dt)
end

function menu.draw()
	for i = 1, #text do
		if selected == i then
			love.graphics.setColor(0, 255, 0)
		else
			love.graphics.setColor(255, 255, 255)
		end
		love.graphics.print(text[i], 10, 10*i)
	end
	love.graphics.setColor(255, 255, 255)

	love.graphics.rectangle("fill", 100, 100, 10, 10)
	love.graphics.rectangle("line", 100, 105, 10, 10)
end

function menu.exit()

end

function menu.keypressed(key)
	if key == "w" and selected > 1 then
		selected = selected - 1
	elseif key == "s" and selected < #text then
		selected = selected + 1
	elseif key ==  "return" then
		load_state(require 'playerselect')
	end
end

return menu