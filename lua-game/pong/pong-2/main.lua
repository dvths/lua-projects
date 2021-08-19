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

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- uma fonte "retro-looking" que podemos usar para qualquer texto.
    smallFont = love.graphics.newFont('font.ttf', 8)

    -- Definir a fonte ativa de LÖVE2D para o objeto smallFont
    love.graphics.setFont(smallFont)
    -- Inicializar a resolução virtual
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
                     {fullscreen = false, resizable = false, vsync = true})
end

function love.keypressed(key) if key == 'escape' then love.event.quit() end end

function love.draw()
    push:apply('start')

    -- limpar a tela com a cor, nesse caso, procurei uma cor similar a do jogo original.
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- As raquetes são simples retangulos desenhados de acordo com as cordenadas do plano 2D.

    -- Renderizar a primeira raquete(lado esquerdo)
    love.graphics.rectangle('fill', 10, 30, 5, 20)

    -- Renderização da segunda raquete (lado direito)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5,
                            20)

    -- Rnderização da bola (centro)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2,
                            VIRTUAL_HEIGHT / 2 - 2, 4, 4)
    push:apply('end')
end
