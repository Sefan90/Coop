local camera = {}
local camMT = {__index = camera}


function camera:set()
	love.graphics.push() 
	love.graphics.translate(-self.cx,-self.cy)
	love.graphics.setScissor(self.tx,self.ty,self.sizex,self.sizey) 
end 

function camera:unset()
	love.graphics.setScissor() 
	love.graphics.pop() 
end 

function camera:getXY()
	return {x = self.cx, y = self.cy}
end
function camera:setXY(newX,newY)
	self.x = newx or 0
	self.y = newy or 0
end

function camera.new(newX,newY,newTX,newTY,newSX,newSY)
	local cam = setmetatable({
		tx = newTX,
		ty = newTY,
		cx = -newX,
		cy = -newY,
		sizex = newSX,
		sizey = newSY
	}, camMT)
	return cam
end

function camera:checkplayer(player)
	local changed = false
	if player.x+player.w/2 < self.cx+self.tx then
		self.cx = self.cx-self.sizex
		changed = true 
	elseif player.x+player.w/2 > self.cx+self.sizex+self.tx then
		self.cx = self.cx+self.sizex
		changed = true 
	elseif player.y+player.h/2 < self.cy+self.ty then
		self.cy = self.cy-self.sizey
		changed = true
	elseif player.y+player.h/2 > self.cy+self.sizey+self.ty then
		self.cy = self.cy+self.sizey
		changed = true
	end
	return changed
end

return camera 


