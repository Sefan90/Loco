local collision = {}

collision.__index = collision

local function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
return x1 < x2+w2 and
    x2 < x1+w1 and
    y1 < y2+h2 and
    y2 < y1+h1
end

function collision.new()
	local self = setmetatable({}, collision)
	self.item = {} --player,x,y,w,h
    return self
end

function collision:add(name,player,x,y,w,h)
	table.insert(self.item,{name,player,x,y,w,h})
end

function collision:remove(name)
	for i = #self.item, 1, -1 do
	 	if self.item[i].name == name then
	    	table.remove(self.item, i)
	  	end
	end
end

function collision:update(name,newx,newy)
	for j = #self.item, 1, -1 do
		if self.item[j].name == name then
			self.item[j].x = newx
			self.item[j].y = newy
			break
		end
	end
end

function collision:check(name,newx,newy)
	local move = false
	for j = #self.item, 1, -1 do
		if self.item[j].name == name then
			move = true 
			for i = #self.item, 1, -1 do
				if self.item[i].name ~= name then
					if CheckCollision(newx,newy,self.item[j].w,self.item[j].h, self.item[i].x,self.item[i].y,self.item[i].w,self.item[i].h) then
						move = false
					end
				end
			end
			if move == true then
				self.item[j].x = newx
				self.item[j].y = newy
			end
			break
		end
	end

end

return collision

