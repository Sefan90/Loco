local player = {}

player.__index = player

local playerfilter = function(item, other)
    if item.name == other.playername then return 'cross'
    elseif other.ground == true then return 'cross'
    elseif other.alive == false then return 'cross'
    else return 'touch'
    end
end

local jumpfilter = function(item, other)
    return 'cross'
end

local bulletfilter = function(item, other)
    if item.playername == other.name then return 'cross'
    elseif item.playername ~= nil and other.playername ~= nil then return 'cross' 
    elseif other.ground == true then return 'cross'
    elseif other.alive == false then return 'cross'
    else return 'touch'
    end
end

local function playermove(self,world,dt)
    --Flytta ut till egen funktion så att döda spelare kan bli knuffade
    if self.push > 0 then
        self.push = self.push - 1
        local actualX, actualY, cols, len = world:move(self, self.x+self.px, self.y+self.py,playerfilter)
        self.x = actualX
        self.y = actualY
    else
        local dx, dy = 0, 0
        if love.keyboard.isDown(self.up) then
            dy = -50*dt
        elseif love.keyboard.isDown(self.down) then
            dy = 50*dt
        end
        if love.keyboard.isDown(self.left) then
            dx = -50*dt
        elseif love.keyboard.isDown(self.right) then
            dx = 50*dt
        end
        if dx ~= 0 and dy ~= 0 then 
            dx, dy = dx*0.707, dy*0.707
        end

        if (dx ~= 0 and dy ~= 0) or (dx == 0 and dy ~= 0) or (dx ~= 0 and dy == 0) then 
            self.dx = dx
            self.dy = dy
        end
        local actualX, actualY, cols, len = world:move(self, self.x+dx, self.y+dy,playerfilter)
        self.x = actualX
        self.y = actualY
    end
end

--Uppdatera så bullets blir en lista och kan innehålla flera bullets
local function playershoot(self,world,dt)
    if love.keyboard.isDown(self.shoot) and self.bullettimer < 0 then
        self.bullettimer = self.maxbullettimer
        self.bullets = {playername = self.name, x=self.x, y=self.y, w=self.w/2, h=self.h/2, dx=self.dx, dy=self.dy, push=100}
        --För att bullets inte ska fastna om man inte rört på sig
        if self.bullets.dx == 0 and self.bullets.dy == 0 then 
            self.bullets.dx = 50*dt
        end
        world:add(self.bullets,self.bullets.x,self.bullets.y,self.bullets.w,self.bullets.h)
    else
        self.bullettimer = self.bullettimer - dt
    end
end

--Uppdatera så bullets behandlas som en lista med flera bullets
local function bulletsmove(self,world,dt)
    if self.bullets ~= nil then
        local actualX, actualY, cols, len = world:move(self.bullets, self.bullets.x+self.bullets.dx, self.bullets.y+self.bullets.dy,bulletfilter)
        self.bullets.x = actualX
        self.bullets.y = actualY
        --KOD för att knuffa player
        local hit = false
        for i = 1, len do
            local other = cols[i].other
            if self.bullets.playername ~= other.name and other.playername == nil and other.alive == true then
                hit = true
                other.px = self.bullets.dx
                other.py = self.bullets.dy
                other.push = self.bullets.push
            end
        end 
        if hit == true or self.bullets.x < 0 or self.bullets.x > 128 or self.bullets.y < 0 or self.bullets.y > 128 then
            world:remove(self.bullets)
            self.bullets = nil
        end
    end
end

local function playercheck(self,world)
    local actualX, actualY, cols, len = world:check(self, self.x, self.y,playerfilter)
    local onground = false
    for i = 1, len do
        local other = cols[i].other
        if other.ground == true then
            onground = true
        end 
    end
    if onground == false then
        self.alive = false
    end
end

local function playerjump(self,dt) 
    if love.keyboard.isDown(self.jump) and self.jumptimer < 0 then 
        self.jumptimer = self.maxjumptimer
        --Frames to next jump 
        local breakloop, jump, x, y = false, 0, 0, 0 
        if self.dx < 0 then
            x = -1
        elseif self.dx > 0 then 
            x = 1
        end 
        if self.dy < 0 then
            y = -1
        elseif self.dy > 0 then 
            y = 1 
        end 
        for i = self.maxjump, 0, -self.w do 
            jump = i
            local actualX, actualY, cols, len = world:move(self, self.x+(x*jump), self.y+(y*jump),jumpfilter) 
            self.x, self.y = actualX, actualY 
            local actualX, actualY, cols, len = world:check(self, self.x, self.y,jumpfilter) 
            for j = 1, len do 
                if cols[j].other.ground == true then 
                    breakloop = true 
                    break 
                end 
            end 
            if breakloop == true then 
                break
            else
                local actualX, actualY, cols, len = world:move(self, self.x-(x*jump), self.y-(y*jump),jumpfilter) 
                self.x, self.y = actualX, actualY
            end 
        end
    else
        self.jumptimer = self.jumptimer - dt
    end 
end

function player.new(name,x,y,w,h,up,left,down,right,shoot,jump)
    local self = setmetatable({}, player)
    self.name = name or ''
    self.alive = true
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.dx = 0
    self.dy = 0
    self.px = 0
    self.py = 0
    self.push = 0
    self.up = up or ''
    self.left = left or ''
    self.down = down or ''
    self.right = right or ''
    self.shoot = shoot or ''
    self.jump = jump or ''
    self.bullets = nil
    self.bullettimer = 0
    self.maxbullettimer = 1
    self.jumptimer = 0
    self.maxjumptimer = 5
    self.maxjump = 32
    return self
end

function player:update(world,dt)
    if self.alive == true then 
        playermove(self,world,dt)
        playershoot(self,world,dt)
        playerjump(self,dt)
        playercheck(self,world)
    elseif self.w > 0 and self.h > 0 then
        self.x = self.x + 0.005
        self.y = self.y + 0.005
        self.w = self.w - 0.01
        self.h = self.h - 0.01
        --world:update(self,self.x,self.y,self.w,self.h)
    end
    bulletsmove(self,world,dt)
end

function player:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    if self.bullets ~= nil then
        love.graphics.rectangle('fill', self.bullets.x, self.bullets.y, self.bullets.w, self.bullets.h)
    end
    local x, y = 4, 4
    if self.name == 'P2' or self.name == 'P4' then
        x = 104
    end
    if self.name == 'P3' or self.name == 'P4' then
        y = 116
    end
    love.graphics.rectangle('fill', x, y, 8, 8)
    love.graphics.rectangle('fill', x+12, y, 8, 8)
end

return player