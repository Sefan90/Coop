local camera = require 'camera'
local func = require 'func'
local menu = {}

function menu.load()
    mapsize = {x=48,y=36}
    width, height = love.graphics.getDimensions()
    tilesize = func.getTileSize(width,height,mapsize)
    tx = (width-tilesize*mapsize.x)/2
    ty = (height-tilesize*mapsize.y)/2
    xsize = width-tx*2
    ysize = height-ty*2
	menu.state = 1
	menu.selected = 0
	camera1 = camera.new(tx,ty,tx,ty,width,height)
end

function menu.update()
	if love.keyboard.isDown('return') then
		if menu.selected == 0 then
			--Play
		elseif menu.selected == 1 then
			--Options
		elseif menu.selected == 2 then
			--Credits
		elseif menu.selected == 3 then
			--Exit
		end
	end
end

function menu.draw()
	camera1:set()
	love.graphics.setShader(myShader)
	love.graphics.rectangle('fill', tilesize, ysize/3, xsize-tilesize*2, ysize/3)
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.rectangle('fill', tilesize*2, ysize/3+tilesize, xsize/3-tilesize*2, ysize/3-tilesize*2)
	love.graphics.rectangle('fill', xsize/3+tilesize, ysize/3+tilesize, xsize/3-tilesize*2, ysize/3-tilesize*2)
	love.graphics.rectangle('fill', xsize/3*2, ysize/3+tilesize, xsize/3-tilesize*2, ysize/3-tilesize*2)
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print('Press enter to start', xsize/2, ysize/2)
	love.graphics.setShader()
	camera1:unset()
	--Play
	--Options
	--Exit
end

function menu.keypressed(key)
	if key == 'return' then
		load_state(require 'game')
	end
end

return menu
