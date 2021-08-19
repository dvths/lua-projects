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
    bonito em sistemas modernos.]] --
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--[[
   É executado quando o jogo é iniciado pela primeira vez, apenas uma vez;  usado para inicializar o jogo.]] --
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, -- Não será tela cheia
        resizable = false, -- Não será redimensionável
        vsync = true -- Mas será sincroniszado com a taxa de atuaização do monitor.
    })
end

--[[
    Chamado após a atualização por LÖVE2D, usado para desenhar qualquer coisa na tela.
]] --
function love.draw()
    love.graphics.printf('Hello Pong!', -- texto a renderizar
    0, -- começando com X (0, pois vamos centralizá-lo com base na largura)
    WINDOW_HEIGHT / 2 - 6, -- começando em  Y (na metade da tela)
    WINDOW_WIDTH, -- número de pixels para centralizar (a tela inteira aqui)
    'center') -- modo de alinhamento, pode ser 'center', 'left', ou 'right'
end
