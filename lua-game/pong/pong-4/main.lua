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

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- "semeando" (ou propagando) o RNG para que a chamadas sejão sempre aleatóreas.
    -- use a hora atual, uma vez que irá variar a cada inicialização.
    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)

    love.graphics.setFont(smallFont)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,
                     {fullscreen = false, resizable = false, vsync = true})

    player1Y = 3
    player2Y = VIRTUAL_HEIGHT - 50

    -- variáveis de velocidade e posição para a bola quando o jogo iniciar.
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- math.random retorna um valor aleatório entre os numeros esquerdo e direito.
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    -- variável de estado do jogo usada para fazer a transição entre as diferentes partes do jogo
    -- (usado para início, menus, jogo principal, pontuação, etc.). 
    -- vamos usar isso para determinar o comportamento durante a renderização e atualização. 
    gameState = 'start'
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        -- adicionar velocidade negativa ao eixo Y atual escalonado por deltaTime
        -- agora, fixamos nossa posição entre os limites da tela
        -- math.max retorna o maior de dois valores; 0 e player Y
        -- irá garantir que não vamos acima disso
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        -- adicionar velocidade positiva ao eixo Y atual escalonado por deltaTime
        -- math.min retorna o menor de dois valores; parte inferior do limite menos a altura da raquete.
        -- e o jogador Y irá garantir que não vamos abaixo dele
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    -- Atualizei a bola com base em seu DX e DY somente se estivermos em estado "play"
    -- Dimensiono a velocidade por dt para que o movimento seja independente da taxa de quadros. 
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end

    function love.keypressed(key)
        if key == 'escape' then
            love.event.quit()

            -- se pressionarmos Enter durante o estado inicial do jogo, entraremos no modo "play" 
            -- durante esse modo, a bola se moverá em uma direção aleatória. 

        elseif key == 'enter' or key == 'return' then
            if gameState == 'start' then
                gameState = 'play'
            else
                gameState = 'start'

                -- Inicialize a bola no meio da tela
                ballX = VIRTUAL_WIDTH / 2 - 2
                ballY = VIRTUAL_HEIGHT / 2 - 2
                -- dada a velocidade x e y da bola, um valor inicial aleatório.
                -- o padrão e/ou (and or) aqui é a maneira de Lua de realizar uma operação ternária
                -- em outras linguagens de programação como C seria ? :.
                ballDX = math.random(2) == 1 and 100 or -100
                ballDY = math.random(-50, 50) * 1.5
            end
        end
    end

    function love.draw()
        push:apply('start')

        love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

        love.graphics.setFont(smallFont)

        if gameState == 'start' then
            love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH,
                                 'center')
        else
            love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH,
                                 'center')
        end

        love.graphics.rectangle('fill', 10, player1Y, 5, 20)

        love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

        love.graphics.rectangle('fill', ballX, ballY, 4, 4)

        push:apply('end')
    end
end
