local func = {}

function func.shallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

function func.getTileSize(width,height)
    if width/64 < height/32 then
        return width/64 --16
    else
        return height/32 --12
    end
end

return func