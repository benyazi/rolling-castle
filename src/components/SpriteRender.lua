local spriteRender = {}

function spriteRender:addSprite(sprite)
    self.sprites[#self.sprites+1] = sprite
end

function spriteRender:new()
    local s = {};
    s.sprites = {}
    return setmetatable(s, {__index=self})
end

return spriteRender