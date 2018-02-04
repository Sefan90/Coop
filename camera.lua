local camera = {}
camera.x = 0
camera.y = 0
camera.w, camera.h = love.graphics.getDimensions()
camera.tx = 0
camera.ty = 0
camera.sizex = 0
camera.sizey = 0


function camera:set()
	love.graphics.push() 
	love.graphics.translate(self.x*(self.w-self.tx*2),-self.y*(self.h-self.ty*2))
	love.graphics.setScissor(self.tx,self.ty,self.sizex,self.sizey) 
end 

function camera:unset()
	love.graphics.setScissor() 
	love.graphics.pop() 
end 

function camera:getXY()
	return {x = self.x, y = self.y}
end
function camera:setXY(newX,newY)
	self.x = newx or 0
	self.y = newy or 0
end

function camera:setscreen(newX,newY,newTX,newTY,newSX,newSY)
	self.x = newx or 0
	self.y = newy or 0
	self.tx = newTX
	self.ty = newTY 
	self.sizex = newSX
	self.sizey = newSY
end

function camera:checkplayer(player)
	local changed = false
	if player.x+player.w/2-camera.tx < -self.x*(self.w-self.tx*2)+1 then
		self.x = self.x+1
		changed = true 
	elseif player.x+player.w/2-camera.tx > -(self.x-1)*(self.w-self.tx*2)-1 then
		self.x = self.x-1
		changed = true 
	elseif player.y+player.h/2-camera.ty < (self.y)*(self.h-self.ty*2)+1 then
		self.y = self.y-1
		changed = true
	elseif player.y+player.h/2-camera.ty > (self.y+1)*(self.h-self.ty*2)-1 then
		self.y = self.y+1
		changed = true
	end
	return changed
end

return camera 


