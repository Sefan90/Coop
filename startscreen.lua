local startscreen = {}

function startscreen.load()
	width, height = love.graphics.getDimensions()
	timer = 0
end

function startscreen.update(dt)
	timer = timer + dt
	if timer > 5 then --Byter till game efter 5 sekunder eller när man trycker return
		load_state(require 'game')
	end
end

function startscreen.draw()
	love.graphics.print('Press enter to start', width/2, height/2)
end

function startscreen.keypressed(key)
	if key == 'return' then
		load_state(require 'game')
	end
end

return startscreen