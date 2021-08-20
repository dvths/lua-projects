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

    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(2) == 1 and math.random(-80, -100) or
                  math.random(80, 100)
end

--[[
Espera uma raquete como argumento e retorna verdadeiro ou falso,
dependendo se os retângulos se sobrepõem.
]]

function Ball:collides(paddle)
    -- primeiro, verifique se a borda esquerda de qualquer um está mais à direita
    -- do que a borda direita do outro 
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.width then
        return false
    end
    -- em seguida, verifique se a borda inferior de qualquer um deles é mais alta 
    -- do que a borda superior borda do outro
    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.height then
        return false
    end

    -- Se o que estiver acima não for verdade, então eles estão se 
    -- sobrepondo
    return true
end

function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
