local assets = {}

local function image(name, fp)
   assets[name] = love.graphics.newImage(fp)
   binser.registerResource(assets[name], name)
end

local function sound(name, fp)
   assets[name] = love.audio.newSource(fp, 'stream')
   binser.registerResource(assets[name], name)
end

function assets.load()
   image('image1', 'assets/sprites/image.png')
   sound('sound1', 'assets/sounds/sound.wav')
end

return assets
