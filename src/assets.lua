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
   image('terrain_grass', 'assets/sprites/grass_001.png')
   image('good1', 'assets/sprites/good1.png')
   image('prayer1_main', 'assets/sprites/tailsetminion_2.png')
   --sound('sound1', 'assets/sounds/sound.wav')
end

return assets
