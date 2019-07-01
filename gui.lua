local gui = {} 

gui.__index = gui

function gui.new(x,y,w,h,text,newgamestate,button)
	local self = setmetatable({}, gui)
	self.x = x 
	self.y = y 
	self.w = w 
	self.h = h 
	self.text = text --{{text,x,y},{text,x,y}}
	self.newgamestate = newgamestate 
	self.button = button --nil or gamestate to change to or function(this) ... end 
	self.selected = false 
	return self 
end 

function gui:update(selected) 
	self.selected = selected 
end 

function gui:draw() 
	if self.selected == true then 
		love.graphics.setColor(0, 255, 0) 
	else 
		love.graphics.setColor(255, 255, 255) 
	end 
	love.graphics.rectangle('line', self.x, self.y, self.w, self.h) 
	for i = 1, #self.text do 
		love.graphics.print(self.text[i][1], self.x+self.text[i][2], self.y+self.text[i][3]) 
	end 
	love.graphics.setColor(255, 255, 255) 
end 

function gui:keypressed(key,scancode,isrepeat) 
	if key == 'space' and self.selected == true and self.button ~= nil then 
		if self.newgamestate == true then 
			--Call change gamestate 
			gamestate = button 
		else 
			--button 
		end 
	end 
end 

function gui:keyreleased(key,scancode) 

end 

return gui 