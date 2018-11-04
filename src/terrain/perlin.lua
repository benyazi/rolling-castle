local Perlin

Perlin = {}
Perlin.__index = Perlin
Perlin.type = 'perlin'

function Perlin:init(_W,_H)
	-- Переопределяем self на новый объект
	--self = setmetatable({}, self)
  math.randomseed(os.time())
  self.world = {w = _W, h = _H}
  self.noyes = {n = {}, w = _W, h = _H}
  self.nonrandomlistcounter = 0
  self.sparsity = .2
  self.clouddefinition = 2
  self.clouddepth = 2
  self.colortype = "landscape"
  self.drawspecific = false
  self.specific = 1
  self.faderatio = 1.5
  self.ps = 1
  self.spacing = 0

  self.nonrandom = false
  self.smoothing = true

  self.textr = 255
  self.textg = 255
  self.textb = 255

  self:initnoise()
  self.noyescloud = (self:cloudmaker(self.noyes, self.clouddepth))
end

function Perlin:nextnonrandomint()
  if self.nonrandomlistcounter > 255 then self.nonrandomlistcounter = 0
  else self.nonrandomlistcounter = self.nonrandomlistcounter + 1
  end
  return self.nonrandomlistcounter
end

function Perlin:getMap()
  return self.noyescloud
end


function Perlin:hof(x,y)
  if x > y then return x
  else return y
  end
end

function Perlin:colorscale(vv)
  if self.colortype == "landscape" then
    self.textr = 250
    self.textg = 0
    self.textb = 0
    if vv < 90 then
      love.graphics.setColor(255,255,255)
    elseif vv < 100 then
      love.graphics.setColor(100,100,100)
    elseif vv < 130 then
      love.graphics.setColor(0,60,0)
    elseif vv <= 255 then
      love.graphics.setColor(0,0,100)
    end
  end
end

function Perlin:initnoise()
  for i = 0, self.noyes.w do
    self.noyes.n[i] = {}
    for j = 0, self.noyes.h do
      if self.nonrandom then
        self.noyes.n[i][j] = self:nextnonrandomint()
      else

      if math.random()<self.sparsity then
        self.noyes.n[i][j] = 0
      else
        self.noyes.n[i][j] = math.random(20,255)
      end
      end
    end
  end
end

function Perlin:makezoomnoise(noi,order)
  newnoi = {n = {}, h = noi.h, w = noi.w}
  for i = 0, newnoi.w do
    newnoi.n[i] = {}
    for j = 0, newnoi.h do
      newnoi.n[i][j] = math.random(1,255)
    end
  end

  for bi = math.floor(noi.w/order), 1, -1 do
    for bj = math.floor(noi.h/order), 1, -1 do
      for j = order, 0, -1 do
        newnoi.n[bi][(bj*order)-j] = noi.n[bi][bj]
        for i = order, 0, -1 do
          newnoi.n[(bi*order)-i][(bj*order)-j] = noi.n[bi][bj]
        end
      end
    end
  end
  return self:makesmoothnoise(newnoi)
end


function Perlin:makesmoothnoise(noi)
  if self.smoothing then
    newnoi = {n = {}, h = noi.h, w = noi.w}
    for i = 0, noi.w do
      newnoi.n[i] = {}
      for j = 0, noi.h do
        local pu = noi.n[i][(j-1)%noi.h]
        local pl = noi.n[(i-1)%noi.h][j]
        local pr = noi.n[(i+1)%noi.h][j]
        local pd = noi.n[i][(j+1)%noi.h]
        local pc = noi.n[i][j]
        newnoi.n[i][j] = (pc+pu+pl+pr+pd)/5
      end
    end
    return newnoi
  else
    return noi
  end
end

function Perlin:drawnoise(noi,order)
  for i = 0, #noi.n do
    noi[i] = {}
    for j = 0, #noi.n[i] do
      love.graphics.setColor(255,255,255, noi.n[i][j]/order)
      self:colorscale(noi.n[i][j]/order)
      love.graphics.rectangle("fill",(i-1)*(self.ps+self.spacing),(j-1)*(self.ps+self.spacing),self.ps,self.ps)
    end
  end
end

function Perlin:cloudmaker(noise, depth)
  local zooms = {}
  zooms[0] = self:makesmoothnoise(noise)
  for i = 1, depth do
    zooms[i] = self:makezoomnoise(zooms[i-1],2)
  end

  local newnoise = zooms[depth-1]
  for i = depth-1, 1, -1 do
    newnoise = (self:compressnoise(newnoise, zooms[i], (depth-i)^self.faderatio))
  end
  if self.drawspecific then
    return zooms[self.specific-1]
  else
    return newnoise
  end
end

function Perlin:compressnoise(n1,n2,order)
  local corder = order+self.clouddefinition
  noise = {n = {}, h = n1.h, w = n1.w}
  for i = 0, n1.w do
    noise.n[i] = {}
    for j = 0, n1.h do
      noise.n[i][j] = 0
      noise.n[i][j] = n1.n[i][j]*(1-(1/corder)) + n2.n[i][j]*(1/corder)
    end
  end
  return self:makesmoothnoise(noise)
end

function Perlin:draw()
  self:drawnoise(self.noyescloud, 1)
  love.graphics.setColor(255,255,255)
  love.graphics.rectangle("fill", 0,0,800,130)
  love.graphics.setColor(self.textr,self.textg,self.textb)
  --
  --  love.graphics.print("Spacebar || New Noise", 350,100,0)
  --
  -- love.graphics.print("1-0 || Cloud Depth: "..tostring(self.clouddepth), 10,10,0)
  --
  -- if drawspecific  then
  --    love.graphics.print("q-p || Specific Layer: "..tostring(not drawspecific), 10,30,0)
  -- else
  -- love.graphics.print("q-p || Specific Layer: "..tostring(clouddepth), 10,30,0)
  -- end
  -- love.graphics.print("a-h || Color Type:  "..tostring(colortype), 11,50,0)
  -- love.graphics.print("z/x || Random Noise?:  "..tostring(not nonrandom), 14,70,0)
  -- love.graphics.print("c/v || Smoothing?:  "..tostring(smoothing), 14,90,0)
  --
  -- love.graphics.print("up/down || pixel size:  "..tostring(ps), 500,10,0)
  -- love.graphics.print("left/right || pixel spacing:  "..tostring(spacing), 500,30,0)
end

return Perlin
