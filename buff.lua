local buff = {}

local function checkplayerbuffs(players,playerbuffselected)
    for i = 1, #players do
        if playerbuffselected == 0 then
            return false
        end
    end
    return true
end

local function NewPlayerBuffs(players,buffs)
    local playerbuffs = {}
    for i = 1, #players do
        --table.add(playerbuffs,{3 random buffs}
    end
    return playerbuffs
end

local function setplayerbuffs(playerbuff,player)
    player.w = player.w + playerbuff.w
    player.h = player.h + playerbuff.h
    player.speed = player.speed + playerbuff.speed
    --...
end

local function newmap(players)
    map, spawnpoints = getnewmap()
    for i = 1, #players do
        players[i].x = spawnpoints[i].x
        players[i].y = spawnpoints[i].y
    end
    return map, players
end


function buff.load(players)
    players = players
    buffs = {...}
    buffposition = {}
    playerbuffs = NewPlayerBuffs(players,buffs)
    playerbuffselected = {0,0,0,0,0,0,0,0}
    map, players = NewMap(players)
end

function buff.update()
    if checkplayerbuffs(players,playerbuffselected) then
        for i = 1, #players do
            setplayerbuffs(playerbuffs[i],players[i])
        end
        load("game",{players,map})
    end
end

function buff.draw()
    for i = 1, #players do
        for j = 1, 3 do
            if playerbuffselected[i] == j then
                love.graphics.setColor(0, 255, 0)
            else
                love.graphics.setColor(255, 255, 255)
            end
            love.graphics.print(playerbuffs[i][j].name, i*10, j*10)
        end
    end
end

function buff.keypressed()
    for i = 1, #players do
        --Playeractions
    end
end