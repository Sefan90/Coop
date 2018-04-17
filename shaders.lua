local shaderdata = {}

shaderdata.shader = love.graphics.newShader[[
      extern vec4 color1;
      extern vec4 color2;
      extern vec4 color3;
      extern vec4 color4;

      vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
        vec4 pixel = Texel(texture, texture_coords );//This is the current pixel color
        if (pixel.a == 0.0) { return vec4(0.0,0.0,0.0,0.0); }
        if (pixel.r < 0.25) { return vec4(color4.r/255,color4.g/255,color4.b/255,color4.a/255); }
        else if (pixel.r < 0.5) { return vec4(color3.r/255,color3.g/255,color3.b/255,color3.a/255); }
        else if (pixel.r < 0.75) { return vec4(color2.r/255,color2.g/255,color2.b/255,color2.a/255); }
        else { return vec4(color1.r/255,color1.g/255,color1.b/255,color1.a/255); }
        return pixel;
      }
    ]]
shaderdata.colortx = 0
shaderdata.colorty = 0
shaderdata.colorx = 2
shaderdata.colory = 2
shaderdata.colors = {
{{255,255,255,1},{255,0,0,1}},
{{0,255,0,1},{0,0,255,1}}
}
shaderdata.player1 = {shaderdata.colors[1][1],shaderdata.colors[1][2],shaderdata.colors[1][3],shaderdata.colors[1][4]}
shaderdata.player2 = {shaderdata.colors[1][1],shaderdata.colors[1][2],shaderdata.colors[1][3],shaderdata.colors[1][4]}

local function player1colors()
	return {
	{shaderdata.colors[1][1],shaderdata.colors[1][2],shaderdata.colors[1][3],shaderdata.colors[1][4]},
	{shaderdata.colors[1][1],shaderdata.colors[1][2],shaderdata.colors[1][3],shaderdata.colors[1][4]}
	}
end

local function player2colors()
	return {
	{shaderdata.colors[1][1],shaderdata.colors[1][2],shaderdata.colors[1][3],shaderdata.colors[1][4]},
	{shaderdata.colors[1][1],shaderdata.colors[1][2],shaderdata.colors[1][3],shaderdata.colors[1][4]}
	}
end

function shaderdata.getcolors(p,i)
	if p == 1 then
		return player1colors()[i]
	else
		return player2colors()[i]
	end
end

function shaderdata.translatecolors(x,y)
	shaderdata.colortx = shaderdata.colortx + x
	shaderdata.colorty = shaderdata.colorty + y
	local temp = {}
	for i = 1, shaderdata.colorx do
	temp[i] = {}
		for j = 1, shaderdata.colory do
			temp[i][j] = shaderdata.colors[i+x][j+y] --lägg till mod här
		end
	end
	shaderdata.colors = temp
end

function shaderdata.translatecolorsto(x,y)
	shaderdata.translatecolors(-shaderdata.colortx+x,-shaderdata.colorty+y)
end

function shaderdata.setshadercolors(i)
    myShader:send('color1', {147,100,209,255})
    myShader:send('color2', {108,70,158,255})
    myShader:send('color3', {77,47,117,255})
    myShader:send('color4', {48,28,76,255})
end

function shaderdata.setshader(i)
	shaderdata.setshadercolors(i)
	return shaderdata.shader
end

function shaderdata.unsetshader()
	return shaderdata.shader
end