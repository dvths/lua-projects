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

--[[
É executado quando o jogo é iniciado pela primeira vez, apenas uma vez;]]

function love.load()
    -- definição do filtro nearest-neighbor.
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Inicialize a resolução virtual.
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
                     {fullscreen = false, resizable = false, vsync = true})
end

--[[
    Tratamento do teclado, chamado por LÖVE2D a cada quadro;
    ]]
function love.keypressed(key)
    -- As chaves podem ser acessadas passando strings com seu nome.
    if key == 'escape' then
        -- função LÖVE que encerrará a aplicação.
        love.event.quit()
    end
end

--[[
   Chamado após a atualização por LÖVE2D, usado para desenhar qualquer coisa na tela.]]
function love.draw()
    -- Inicia a resolução virtual
    push:apply('start')

    -- Desenhe o texto de boas vindas na parte superior da tela
    love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6,
                         VIRTUAL_WIDTH, 'center')

    -- Termina a resolução virtual
    push:apply('end')
end
