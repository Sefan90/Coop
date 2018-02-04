local func = {}

function func.shallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

function func.getTileSize(width,height)
    if width/16 < height/12 then
        return width/16
    else
        return height/12
    end
end

return func