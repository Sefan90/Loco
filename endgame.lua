local endgame = {}

function endgame.load(players)
    players = players
    sortedplayers = players--sortplayers(players)
    menu = {"Exit"}
    selected = 1
end

function endgame.update()

end

function endgame.draw()
    for i = 1, #sortedplayers do
        love.graphics.print(sortedplayers[i].name.." "..sortedplayers[i].score, 100, i*10)
    end
    for i = 1, #menu do
        love.graphics.print(menu[i], 200, i*10)
    end
end

function endgame.keypressed(key)
    for i = 1, #players do
        if key == players[i].start then
            load("menu")
        end
    end
end

return endgame