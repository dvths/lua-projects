--[[
    Autor: Tiago Henrique
    tiagohs.dev@gmail.com

    Exercício do curso de desenvolvimento de jogos
    CS50 - Instrutor Colton Ogden - cogden@cd50.harvard.edu

    Originalmente programado Nolan Bushnell e Ted Dabney
    na forma de console ligado a um monitor movido a fichas,
    "Pong" foi o primeiro game lucrativo da história dando
    origem a fundação da empresa Atari, em 1972 e a um novo
    setor da industria.

    O game em duas dimensões, simula tênis de mesa onde dois
    jogadores têm o objetivo de mandar a bola além da borda do
    seu oponente. Vence o primeiro a marcar 10 pontos.

    Esta versão é construída para se parecer mais com o NES do que
    as máquinas Pong originais ou o Atari 2600 em termos de
    resolução, embora em widescreen (16: 9) para que fique mais
    bonito em sistemas modernos.
    ]] --
-- push é uma biblioteca que nos permite desenhar o jogo em um ambiente virtual
-- resolução, em vez do "tamanho" da janela;
-- usado para uma estética mais retrô
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- velocidade com que movemos a raquete; multiplicado por dt na atualização.
PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    smallFont = love.graphics.newFont('font.ttf', 8)

    scoreFont = love.graphics.newFont('font.ttf', 32)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
                     {fullscreen = false, resizable = false, vsync = true})

    -- inicializar as variáveis de pontuação, usadas para renderizar os pontos na tela
    -- e monitorar o vencedor.

    player1Score = 0
    player2Score = 0

    -- posições da raquete no eixo Y (elas só se movem para cima e para baixo).
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

function love.update(dt)
    -- movimento do player 1
    if love.keyboard.isDown('w') then
        -- adicionar a velocidade negativa da raquete ao Y atual escalonado por DeltaTime.
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        -- adicionar a velocidade positiva da raquete ao Y atual scalonado por DeltaTime.
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- movimento do player 2 
    if love.keyboard.isDown('up') then
        -- adicionar a velocidade negativa da raquete ao Y atual escalonado por DeltaTime.
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        -- adicionar a velocidade positiva da raquete ao Y atual scalonado por DeltaTime.
        player2Y = player2Y + PADDLE_SPEED * dt
    end
end

function love.keypressed(key) if key == 'escape' then love.event.quit() end end

function love.draw()
    push:apply('start')

    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(smallFont)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- Desenha a pontuação no centro esquerdo e direito da tela.
    -- Precisamos mudar a fonte para desenhar antes de realmente imprimir.
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
                        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
                        VIRTUAL_HEIGHT / 3)

    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2,
                            VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    push:apply('end')
end
