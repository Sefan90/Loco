local player = require 'player'
local bump = require 'bump'
local map = require 'map'
local gui = require 'gui'
local game = {}
-- 8x8 grid för varje object. 
-- Pico 8 färger
-- börja med rectangle collision och optimera med circle collision?

love.graphics.setLineStyle "rough"
love.graphics.setDefaultFilter("nearest", "nearest")

function game.load(input,input2)
    canvas = love.graphics.newCanvas(128,128)
    world = bump.newWorld()
    players = {}
    --print(input[1].name..input[1].x..input[1].y..input[1].w..input[1].h..input[1].up..input[1].left..input[1].down..input[1].right..input[1].A..input[1].B)
    for i = 1, #input do
        table.insert(players,player.new(input[i].name,input[i].x,input[i].y,input[i].w,input[i].h,input[i].up,input[i].left,input[i].down,input[i].right,input[i].A,input[i].B))
    --end --Kan man ska en for loop?
    --for i = 1, #players do
        world:add(players[i],players[i].x,players[i].y,players[i].w,players[i].h)
    end
    level1 = map.new(4,world)
    text = gui.new(0,0,0,0,{{'Some',40,0},{'text',64,0}})
end

function game.update(dt)
    for i = 1, #players do
        players[i]:update(world,dt)
    end
    level1:update(world,dt)
end

function game.draw()
    level1:draw()
    for i = 1, #players do
        players[i]:draw()
    end
    text:draw()
end

return game