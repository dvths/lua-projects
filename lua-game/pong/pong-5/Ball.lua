--[[
    -- Ball Class --

    Autor: Tiago Henrique
    Cs50 GameDev - Instrutor Colton Ogden
    cogden@cs50.harvard.edu

    Representa uma bola que vai quicar para frente e para trás entre as raquetes
    e paredes até passar um limite esquerdo ou direito da tela, marcando um ponto
    para o adversário.

   ]] --
Ball = Class {}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- essas variáveis são para manter o controle da velocidade em ambos os
    -- eixos X e Y, uma vez que a bola pode se mover em duas dimensões
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    Coloca a bola no meio da tela, com uma velocidade inicial aleatória 
    em ambos os eixos.
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

--[[
    Simplesmente aplica a velocidade à posição, escalonada por DeltaTime. 
]]
function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end
-- Definimos um método que irá renderizar a bola na tela
function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
