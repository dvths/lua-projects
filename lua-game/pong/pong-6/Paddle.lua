--[[
    -- Ball Class --

    Autor: Tiago Henrique
    Cs50 GameDev - Instrutor Colton Ogden
    cogden@cs50.harvard.edu

    Representa uma raquete que pode se mover para cima e para baixo.  Usado no principal.
    programa para desviar a bola de volta para o adversário.
]] --
Ball = Class {}
Paddle = Class {}

--[[
    A função `init` na classe é chamada apenas quando o objeto
    é criado pela primeira vez. Usado para configurar todas as variáveis na classe e obtê-lo
    pronto para uso.
    A raquete deve ter um X e um Y, para o posicionamento, bem como uma largura
    e altura para suas dimensões.

    Observe que `self` é uma referência a este objeto, qualquer que seja o objeto
    instanciado no momento em que esta função é chamada.  Objetos diferentes podem
    ter seus próprios valores de x, y, largura e altura, servindo assim como contêineres
    para dados. Nesse sentido, são muito semelhantes às estruturas em C.
    ]] --
function Paddle:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)

    -- math.max aqui garante o limite máximo entre 0 e player
    -- posição atual de  Y  é calculada ao pressionar up para que não
    -- vá para a parte negativa do eixo; o cálculo do movimento é simplesment
    -- a velocidade da raquete (definida anteriormente) escalonada por dt

    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
        -- desta vez usamos math.min para garantir que a raquete não vá além
        -- da parte inferior da tela.
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

--[[
    Essa função será chamada na main em `love.draw`.
    A função `rectangle` de LÖVE2D assume um modo de desenho como o primeiro
    argumento, bem como a posição e as dimensões do retângulo.  Para mudar a cor,
    deve-se chamar `love.graphics.setColor`. A partir de versão mais recente
    do LÖVE2D, você pode até desenhar retângulos arredondados!
    ]] --
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
