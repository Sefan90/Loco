playerselect = {}

local function table_contains(tbl, element)
    for _, value in pairs(tbl) do
        if value == element then
              return true
        end
    end
    return false
end

local function table_remove(tbl, element)
	for i = #tbl, 1, -1 do
    	if tbl[i] == element then
      		table.remove(tbl, i)
      		break
    	end
  	end
end

function playerselect.load()
    --Load key/controller binds
    sendplayers = {}
    players = {
    {name = 'P1', x = 28, y = 28, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = 'space', B ='q', Start = 'return'},
    {name = 'P2', x = 92, y = 28, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = '1', B ='q', Start = 'return'},
    {name = 'P3', x = 28, y = 92, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = '2', B ='q', Start = 'return'},
    {name = 'P4', x = 92, y = 92, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = '3', B ='q', Start = 'return'},
	{name = 'P5', x = 60, y = 28, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = '4', B ='q', Start = 'return'},
    {name = 'P6', x = 60, y = 92, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = '5', B ='q', Start = 'return'},
    {name = 'P7', x = 28, y = 60, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = '6', B ='q', Start = 'return'},
    {name = 'P8', x = 92, y = 60, w = 8, h = 8, up = 'w', left = 'a', down = 's', right = 'd', A = '7', B ='q', Start = 'return'}}
    map = {0}
end

function playerselect.update()

end


function playerselect.draw()
    --Draw a map you cant die on
    for i = 1, #players do
        if table_contains(sendplayers,players[i]) then
            love.graphics.rectangle('fill',players[i].x,players[i].y,players[i].w,players[i].h)
        else
            love.graphics.print("Press A to join",players[i].x,players[i].y)
        end
    end
end

function playerselect.keypressed(key)
	local loadgame = false
    for i = 1, #players do
        if key == players[i].A and not table_contains(sendplayers,players[i]) then
            table.insert(sendplayers,players[i])
        elseif key == players[i].B and table_contains(sendplayers,players[i]) then
        	table_remove(sendplayers,players[i])
        elseif key == players[i].Start and #sendplayers > 1 then
        	loadgame = true
        end
    end
    if loadgame == true then
    	load_state(require "game",sendplayers,map)
	end
end

return playerselect