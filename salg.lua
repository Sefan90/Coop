local func = require 'func'
local salg = {} 
salg.cameradata = nil
salg.playerdata = nil
salg.file = nil

local function createsavefile() 
	--crate save file if there is none 
end 

function salg:savefile(playerdata) 
	self.playerdata = func.shallowCopy(playerdata)
	--save to file
end 

function salg:loadfile() 
	--load from file
	return self.cameradata, self.playerdata
end 

function salg:save(playerdata)
	self.playerdata = func.shallowCopy(playerdata)
end 

function salg:load() 
	return func.shallowCopy(self.playerdata)
end 

return salg