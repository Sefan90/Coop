local camera = require 'camera'
local func = require 'func'
local menu = {}
local selectrow = 0

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
end

function menu.draw()
	camera1:set()
	--love.graphics.setShader(myShader)
	love.graphics.print('->', xsize/2, ysize/2+tilesize*selectrow)
	love.graphics.print('	Press enter to start', xsize/2, ysize/2)
	love.graphics.print('	Options', xsize/2, ysize/2+tilesize)
	love.graphics.print('	Exit', xsize/2, ysize/2+tilesize*2)
	--love.graphics.setShader()
	camera1:unset()
end

function menu.keypressed(key)
	if key == 'return' then
		if selectrow == 0 then
			load_state(require 'game')
		elseif selectrow == 1 then
			load_state(require 'options')
		else
			love.event.quit()
		end
	elseif key == 'w' and selectrow ~= 0 then
		selectrow = selectrow - 1
	elseif key == 's' and selectrow ~= 2 then
		selectrow = selectrow + 1
	end
end

return menu
