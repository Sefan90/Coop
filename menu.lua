local func = require 'func'

local menu = {}
menu.selected = 0

local mapsize = {x=48,y=36}
local width, height = love.graphics.getDimensions()
local tilesize = func.getTileSize(width,height,mapsize)

function menu.update(players,esc)
	if love.keyboard.isDown(players[1].nextlevel) or love.keyboard.isDown(players[2].nextlevel) then
		if menu.selected == 0 then
			--Paused/resume
			esc.active = false
		elseif menu.selected == 1 then
			--Restart
			players[1].reloadpressed = true
			players[2].reloadpressed = true
			esc.active = false
		elseif menu.selected == 2 then
			--Save
		elseif menu.selected == 3 then
			--Save and exit
		end
	end
end

function menu.draw()
	love.graphics.setColor(255, 255, 255)
	love.graphics.rectangle('fill', width/5*2, height/3-tilesize/2, width/5, height/3+tilesize)
	for i = 0, 3 do
		if i == menu.selected then
			love.graphics.setColor(0, 255, 0)
		else
			love.graphics.setColor(0, 0, 0)
		end
		love.graphics.rectangle('fill', width/5*2+tilesize, height/3+tilesize*(0.5+i*3), width/5-tilesize*2, tilesize*2)
	end
	love.graphics.setColor(255, 255, 255)
end

return menu

	-- love.graphics.print('PAUSED', width/3+width/6, height/3+tilesize)
	-- love.graphics.print('RESTART', width/3+width/6, height/3+tilesize*2)
	-- love.graphics.print('SAVE', width/3+width/6, height/3+tilesize*3)
	-- love.graphics.print('SAVE and exit', width/3+width/6, height/3+tilesize*4)