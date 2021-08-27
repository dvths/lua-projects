# Um remake de PONG (Atari, 1972) escrito em LUA

## Introdução

Esse tutorial é faz parte de uma série de estudos pessoais sobre
desenvolvimento de jogos e a linguagem de programação Lua. Para segui-lo
é recomendável (mas não obrigatório) que você possua um conhecimento
básico de programação e, de preferência, familiaridade com Lua e com o
mínimo dos padrões de desenvolvimento de games.

No decorrer do artigo compartilharei links para materiais de apoio úteis
para a compreensão de certos conceitos. Tentarei ser o mais objetivo e
claro possível e, o mais importante: estou aberto para esclarecer
dúvidas e receber sugestões de melhorias! Ficarei muito feliz em trocar
ideias com pessoas que possam me ajudar a melhorar minhas habilidades.

Por fim, vou assumir que você está desenvolvendo em um sistema Linux. Eu
uso Arch Linux e há anos não uso Windowns ou Mac para além do
*básico-bem-básico* , mas tenho certeza que, para a instalação das
ferramentas que usaremos, as diferenças não são profundas. Além disso,
meu editor é o NeoVim. Portanto, no caso de dúvidas do tipo "*como se
faz isso no editor X ou no sistema Y?"* , saiba que não terei tanta
propriedade para responder, mas tentarei ajudar no que for possível.

Dito isso, vamos lá:

## Tópicos

-   **Lua**
    -   Esta é a linguagem de programação que usarei em todos os
        projetos que pretendo postar.
        [Lua](https://www.lua.org/about.html) foi criada pela PUC do
        Rio🇧🇷, uma linguagem de script dinâmica semelhante a Python e
        JavaScript. Ela é amplamente utilizada para desenvolvimento de
        jogos e softwares embarcados. Infelizmente, apesar de ter sido
        criado por aqui, Lua não é tão difundida no Brasil, mas é
        amplamente utilizada no desenvolvimento de diversos softwares e
        games no exterior. Se quiser ver uma lista clique
        [aqui](https://pt.wikipedia.org/wiki/Lua_(linguagem_de_programa%C3%A7%C3%A3o)).
-   **LÖVE2D**
    -   A engine que usrei. Ele funciona lado a lado com Lua e você pode
        encontrar sua documentação em
        [love2d.org/wiki/Main_Page](https://love2d.org/wiki/Main_Page) .
-   **Desenhando formas e texto**
    -   Nos debriçaremos sobre dois dos princípios mais básicos do
        desenvolvimento de jogos: A capacidade de desenhar formas e
        texto e renderizá-los na tela.
-   **DeltaTime e velocidade**
    -   DeltaTime, sem dúvida é uma das variáveis mais importantes em
        qualquer framework de desenvolvimento de games, é o tempo
        decorrido desde a execução do último frame. LÖVE2D mede
        DeltaTime em termos de segundos, então veremos como esse
        conceito se relaciona com a velocidade.
-   **Game State**
    -   Cada jogo é composto de uma série de estados (por exemplo, o
        estado da tela do título, estado do jogo, estado do menu, etc.),
        portanto, será importante entender este conceito, já que
        queremos uma lógica de renderização diferente e uma lógica de
        atualização para cada estado.
-   **POO Básico (programação orientada a objetos)**
    -   O uso da Programação Orientada a Objetos nos permitirá
        encapsular nossos dados e objetos de jogo de forma que cada
        objeto em nosso jogo seja capaz de rastrear todas as informações
        que são relevantes para ele, bem como ter acesso a funções
        específicas. Veremos alguns conceitos básicos de POO mais
        detalhadamente.
-   **Box Collision (Hitboxes)**
    -   Entender o conceito de colisão será necessário para dar vida a
        Pong, já que precisaremos ser capazes de fazer a bola "quicar"
        para frente e para trás entre duas raquetes. A bola e as
        raquetes serão retangulares, então vamos nos concentrar em
        "Caixas delimitadoras alinhadas ao eixo", que nos permitirá
        calcular as colisões de forma mais simples aplicando o conceito
        de colisão AABB.
-   **Efeitos sonoros (com LLVM)**
    -   Por fim, veremos como aprimorar nosso jogo com efeitos sonoros
        para torná-lo mais atraente e envolvente ;\*.

# Instalando LÖVE2D e Lua

-   Antes de começar, certifique-se de ter o LÖVE2D instalado em sua
    máquina, o que você pode fazer através do seguinte link:

    -   [love2d Download!](https://love2d.org/#download) .

-   Está disponível para todos os principais sistemas operacionais
    (Windows, Mac, Linux). Se você precisar de algumas dicas sobre como
    começar a fazer funcionar em sua máquina, confira este link:

    -   [Love2d Start!](https://love2d.org/wiki/Getting_Started) .

-   Lua Para instalar a linguagem Lua em sua máquina também é muito
    simples, basta seguir o passo a passo na página da linguagem:

    -   [Lua Start!](https://www.lua.org/start.html) .

## Baixando código de demonstração

-   Em seguida, faça um clone do repositório que eu deixei no jeito para
    você estudá-lo e acompanhar com mais facilidade o tutorial:

    -   \[link do repo\]

## Por que Lua?

-   Lua foi criada em 1993 aqui no Brasil e se destina ao uso embutido
    em em grandes aplicações. Por ser extremamente leve e rápida, desde
    sua seu desenvolvimento, tornou-se muito popular na indústria de
    games.

-   É uma linguagem de script flexível, fácil de assimilar e focada em
    "tabelas", que são semelhantes a dicionários em Python e objetos em
    JavaScript (se você não sabe o que isso quer dizer não tem problema!
    Você vai entender logo).

-   Lua é excelente para armazenar dados (ela se beneficia de um design
    orientado a dados).

## E por que LÖVE2D?

-   Primeiro por que LÖVE2D é uma estrutura de desenvolvimento de jogos
    2D open source, acessível, leve e rápida escrita em C++ que usa Lua
    como sua linguagem de script.

-   É bem completo! Contém módulos para gráficos, entrada de teclado,
    matemática, áudio, janelas, física e muito mais. Tudo o que
    realmente precisamos!

-   Além do mais, é possível construir seus projetos de maneira portátil
    para todos os principais desktops e Android/iOS.

-   Também é ótimo para prototipagem e estudo.

## Pong

![Pong!](https://cs50.harvard.edu/games/2018/notes/0/pong_example.png)

Pong é considerado o primeiro jogo de sucesso comercial. O jogo foi
originalmente desenvolvido por Allan Alcorn e lançado em 1972 pelas
empresa Atari e se tornou um enorme sucesso! Em 1975, a Atari lançou a
edição *caseira* de Pong (as primeiras eram desenvolvidas para máquinas
Arcade) que vendeu 150.000 unidades e deu início à industria de
videogames demosntrando o alto podencial lucrativo que esse mercado
podia alcançar.

É um jogo simples: simula uma especie de tênis de mesa. Com duas
raquetes e uma bola, o objetivo é derrotar seu oponente sendo o primeiro
a marcar 10 pontos, isto é, mandando a bola para os limites esquerdo ou
direito da tela.

# Introduzindo conceitos

Nessa seção vamos dar uma olhada de uma forma bem objetiva nos conceitos
introdutórios dessa fase de desenvolvimento do projeto:

-   Loop de Jogo;
-   Sistemas de coordenadas;
-   Escopo do projeto;

## O que é um loop de jogo?

-   Um jogo, fundamentalmente, é um loop infinito, como um
    `while(true)`ou um `while(1)`. Durante cada iteração desse loop,
    executamos repetidamente o seguinte conjunto de etapas:
    -   Primeiro, estamos processando a entrada. Ou seja, estamos
        constantemente verificando se o usuário pressionou uma tecla no
        teclado, moveu o joystick, moveu/clicou com o mouse, etc.

    -   Em segundo lugar, precisamos responder a essa entrada
        atualizando qualquer coisa no jogo que dependa dessa entrada (ou
        seja, rastreando o movimento, detectando colisões, etc.).

    -   Terceiro, precisamos renderizar novamente tudo o que foi
        atualizado na etapa anterior, para que o usuário possa ver na
        tela que mudou no jogo e ter uma sensação de interatividade.

    > ![Foto tirada de Game Programming Patterns:
    > <http://gameprogrammingpatterns.com/game-loop>](http://gameprogrammingpatterns.com/images/game-loop-simple.png)

## Sistema de Coordenadas 2D

-   No contexto de jogos 2D, a maneira fundamental de ver o mundo é
    usando o sistema de coordenadas 2D.

-   Parece óbvio a princṕio, mas álgebra linear para computação gráfica
    é um pouco diferente do sistema tradicional que você pode ter
    aprendido na aula de matemática. O sistema de coordenadas 2D a que
    me refiro aqui é um sistema no qual os objetos têm uma coordenada X
    e Y (X, Y) em que (0, 0) é o canto superior esquerdo do sistema.
    Isso significa que as direções positivas se movem para baixo e para
    a direita, enquanto as direções negativas se movem para cima e para
    a esquerda.

    > ![Imagem retirada de
    > rbwhitaker.wdfiles.com/local--files/monogame-introduction-to-2d-graphics/2DCoordinateSystem.png](http://rbwhitaker.wdfiles.com/local--files/monogame-introduction-to-2d-graphics/2DCoordinateSystem.png)

## Escopo do Projeto

-   Primeiro, queremos desenhar formas na tela (por exemplo, raquetes e
    bola) para que o usuário possa ver o jogo.

-   Em seguida, queremos controlar a posição 2D das raquetes com base na
    entrada e implementar a detecção de colisão entre as raquetes e a
    bola para que cada jogador possa desviar a bola de volta para seu
    oponente.

-   Também precisaremos implementar detecção de colisão entre a bola e
    os limites da tela para manter a bola dentro dos limites verticais
    da tela e para detectar eventos de pontuação (fora dos limites
    horizontais).

-   Nesse ponto, queremos adicionar efeitos sonoros para quando a bola
    atingir as raquetes e as paredes e para quando um ponto for marcado.

-   Por último, exibiremos o placar na tela (só para que os jogadores
    não fiquem tentando marcar tudo em um papelzinho :) ).

# Um passo de cada vez

Nessa seção vamos iniciar a estrutura do projeto.

Neste ponto, você desejará ter baixado o código de demonstração para
continuar. Preste atenção aos comentários no código!

Nas seções respectivas de cada diretório nesse artigo (0 à 12), você
encontrará explicações mais detalhadas e, eventualmente, links para
material de apoio e pesquisa.

Divirta-se!

## pong-0 - "Hello, Pong!"

-   pong-0 simplesmente imprime "Hello Pong!" exatamente no centro da
    tela. Claro que isso não é incrivelmente empolgante, mas mostra como
    usar as funções mais importantes do LÖVE2D no futuro.

### Funções Importantes

-   `love.load()`

    -   Esta função é usada para inicializar o estado do jogo no início
        da execução do programa. Qualquer código que colocarmos aqui
        será executado uma vez no início do programa.

-   `love.update(dt)`

    -   Esta função é chamada pelo LÖVE em cada quadro de execução do
        programa; `dt`(ou seja, DeltaTime) se trata do tempo decorrido
        em segundos desde o último quadro, e podemos usar isso para
        dimensionar quaisquer mudanças em nosso jogo para um
        comportamento uniforme nas taxas de quadros.

-   `love.draw()`

    -   Esta função também é chamada a cada quadro pelo LÖVE. Ela é
        chamada após a conclusão da etapa de atualização para que
        possamos desenhar as coisas na tela depois de qualquer
        alterações.

-   LÖVE2D espera que essas funções sejam implementadas no arquivo
    `main.lua` e as chama internamente; se não os definirmos, ainda
    funcionará, mas nosso jogo será fundamentalmente incompleto, pelo
    menos se `update`ou `draw` estiverm faltando!

-   `love.graphics.printf(text, x, y, [width], [align])`

    -   Função de impressão versátil que pode alinhar o texto à
        esquerda, direita ou centralizado na tela.

-   `love.window.setMode(width, height, params)`

    -   Usada para inicializar as dimensões da janela e definir
        parâmetros como `vsync`(sincronização vertical), se estamos em
        tela cheia ou não, e se a janela pode ser redimensionada após a
        inicialização. Não usaremos esta função após este exemplo graças
        a biblioteca `push` que nos permitirá criar uma resolução
        virtual que possui um método parecido com este. Contudo é útil
        saber se encontrada em outro código.

-   Agora, com as peças do quebra-cabeça em mente, você pode ver como
    estamos renderizando "Hello Pong!" para o centro da tela!

### Código importante

-   Inicializamos nosso jogo usando a função `love.load()` para
    especificar as dimensões da janela de jogo com 1280x720. Também não
    queremos iniciar em tela cheia ou tornar a janela redimensionável,
    mas queremos que seja sincronizada com a taxa de atualização do
    próprio monitor.

``` lua
        WINDOW_WIDTH = 1280
        WINDOW_HEIGHT = 720

        function love.load()
            love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
                fullscreen = false,
                resizable = false,
                vsync = true
            })
        end`
```

-   Em seguida, sobrescrevemos `love.draw()` para que possamos
    especificar o texto que a ser renderizado na tela, neste caso "Hello
    Pong!", junto com as coordenadas de onde deve ser desenhado.

``` lua
        `function love.draw()
            love.graphics.printf(
                'Hello Pong!',          
                0,                      
                WINDOW_HEIGHT / 2 - 6,  
                WINDOW_WIDTH,           
                'center')             
        end`
```

## pong-1 - A atualização de baixa resolução

-   pong-1 exibe o mesmo comportamento que pong-0, mas com texto muito
    mais "borrado", isso dá um toque meio retrô 😉.

### Funções Importantes

-   `love.graphics.setDefaultFilter(min, mag)`
    -   Esta função define o filtro de escala de textura ao minimizar e
        ampliar texturas e fontes; O padrão do LÖVE é bilinear, o que
        causa manchas, mas para esse caso, normalmente queremos
        "*filtragem de vizinho mais próximo*" (`nearest`), o que resulta
        em aumento e redução de pixel perfeitos, simulando quela
        sensação retro.

> **Nota**: Interpolação e escala de imagens digitais é um assunto bem
> interessante e fundamental para lidar com imagens no computador. Você
> pode começar a se aprofundar no assunto por
> [aqui](https://en.wikipedia.org/wiki/Image_scaling).

-   `love.keypressed(key)`
    -   Esta é um *callback* de LÖVE2D que é executado sempre que
        pressionamos uma tecla, assumindo que implementamos isso em
        `main.lua`, na mesma linha que `love.load()`, `love.update(dt)`,
        e `love.draw()`, nos permitirá receber informações do teclado
        para os controles do jogo.
-   `love.event.quit()`
    -   Esta é uma função simples que encerra a execução do aplicativo.

### Código Importante

-   Ao abrir o pong-1, você perceberá a biblioteca `push` à qual me
    referi anteriormente. Você pode "importar" outros arquivos em seu
    arquivo `main.lua` com a palavra-chave `require`, uma vez que
    estejam no mesmo diretório.

-   Além disso, também adicionamos duas novas variáveis ao código:

``` lua
        push = require 'push'

        WINDOW_WIDTH = 1280
        WINDOW_HEIGHT = 720

        VIRTUAL_WIDTH = 432
        VIRTUAL_HEIGHT = 243
```

Isso nos permitirá pensar o esstilo do jogo em termos de resolução mais
baixa. Uso `push` para tratar jogo como se estivesse em uma janela de
432x243,enquanto realmente o renderiza em uma janela de 1280x720 (bem
legal, né?!).

Com essa mudança, você pode ver que atualizei `love.load()` em
conformidade com essa ideia:

``` lua
        function love.load()
            love.graphics.setDefaultFilter('nearest', 'nearest')

            push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
                fullscreen = false,
                resizable = false,
                vsync = true
            })
        end
```

-   Também adicionei uma maneira de sair do jogo por meio da entrada do
    usuário, usando duas das funções discutidas acima:

``` lua
        function love.keypressed(key)
            if key == 'escape' then
                love.event.quit()
            end
        end
```

Incluindo este código em `main.lua` garantimos que o programa sempre
monitore se o usuário pressionou o `escape`em seu teclado. Se sim,
`love.event.quit()`será chamado para encerrar o programa.

-   Por último, fiz um pequeno ajuste em `love.draw()` de modo a
    integrar a `push` no código.

``` lua
        function love.draw()
            push:apply('start')
            love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')
            push:apply('end')
        end
```

Você notará que a declaração de impressão permanece inalterada, mas nós
a envolvemos entre `push:apply('start')`e `push:apply('end')`para
garantir que seu conteúdo seja processado na resolução virtual desejada.

-   Com essas mudanças, você perceberá que, embora o print ainda seja
    "Hello Pong!" no centro da tela, o texto agora é ampliado e
    renderizado em uma resolução mais baixa, apesar do tamanho da janela
    ser o mesmo de antes.

## pong-2 - A atualização do retângulo

-   pong-2 produz uma imagem mais completa, embora estática, de como o
    programa Pong deve se parecer.

### Funções Importantes

-   `love.graphics.newFont(path, size)`
    -   Esta função carrega um arquivo de fonte na memória em um caminho
        específico, definindo-o para um tamanho específico e
        armazenando-o em um objeto que podemos usar para alterar
        globalmente a fonte atualmente ativa que LÖVE2D está usando para
        renderizar texto.
-   `love.graphics.setFont(font)`
    -   Esta função define a fonte atualmente ativa de LÖVE2D (da qual
        só pode haver uma de cada vez) para uma fonte um objeto `font`
        que podemos criar usando `love.graphics.newFont`.
-   `love.graphics.clear(r, g, b, a)`
    -   Esta função pinta a tela inteira com uma cor definida por um
        conjunto [RGBA](https://en.wikipedia.org/wiki/RGBA_color_model).
        Cada componente varia entre 0-255.
-   `love.graphics.rectangle(mode, x, y, width, height)`
    -   Desenha um retângulo na tela usando qualquer que seja a cor
        ativa (`love.graphics.setColor` é a função que nos ajuda com as
        cores, mas não precisamos usar neste projeto específico, pois
        quase tudo é branco, a cor padrão LÖVE2D). O parâmetro `mode`
        pode ser definido para `fill`ou `line`, que resulta em um
        retângulo preenchido ou contornado, respectivamente, e os outros
        quatro parâmetros são suas dimensões de posição e tamanho. Esta
        é a função de desenho fundamental de toda a nossa implementação
        de Pong!

### Codigo Importante

-   Você verá, no diretório, junto do arquivo `main.lua` e da biblioteca
    `push`, que adicionei um arquivo de fonte ao projeto.

-   Nesse ponto, você encontrará uma pequena adição na função
    `love.load()`:

``` lua
        smallFont = love.graphics.newFont('font.ttf', 8)
        love.graphics.setFont(smallFont)
```

Isso nos permitirá criar um objeto de fonte personalizado (baseado no
arquivo de fonte que adicionamos ao diretório do projeto) que podemos
definir como a fonte ativa do jogo.

-   As únicas outras mudanças no código nesta atualização podem ser
    encontradas na função `love.draw()`.

``` lua
        love.graphics.clear(40/255, 45/255, 52/255, 255/255)

        love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

        love.graphics.rectangle('fill', 10, 30, 5, 20)
        love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)
        love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)
```

Como você pode ver, estamos definindo o plano de fundo com uma cor
escura, movendo "Hello Pong!" mais acima na tela, e desenhando
retângulos para as raquetes e a bola. As raquetes são posicionadas em
extremidades opostas da tela e a bola no centro.

## pong-3 - Atualização da Raquete

-   pong-3 Adiciona interatividade às raquetes, permitindo-nos movê-las
    para cima e para baixo usando o `w` e `s`, para a raquete da
    esquerda e as teclas up e down para a raquete da direita.

### Funções Importantes

-   `love.keyboard.isDown(key)`
    -   Esta função retorna verdadeiro ou falso se a tecla especificada
        está pressionada atualmente; difere de `love.keypressed(key)`
        dado que essa pode ser chamada arbitrariamente e retornará
        continuamente verdadeiro se a tecla for pressionada, enquanto
        `love.keypressed(key)`irá disparar seu código apenas uma vez
        sempre que a tecla for pressionada inicialmente. No entanto, uma
        vez que queremos ser capazes de mover as raquetes para cima e
        para baixo mantendo pressionadas as teclas apropriadas,
        precisamos de uma função para testar períodos mais longos de
        entrada, daí o uso de `love.keyboard.isDown(key)`.

### Código Importante

-   Você notará que adicionamos uma nova constante perto do topo de
    `main.lua`:

``` lua
        PADDLE_SPEED = 200
```

Este é um valor arbitrário que escolhi para velocidade das raquetes. Ele
será escalado por DeltaTime, então ele será multiplicado por quanto
tempo passou (em termos de segundos) desde o último quadro, de modo que
nosso movimento de remo permanecerá consistente independentemente de
quão rápido ou devagar o computador esteja funcionando.

-   Você também encontrará algumas novas variáveis em `love.load()`:

``` lua
        scoreFont = love.graphics.newFont('font.ttf', 32)

        player1Score = 0
        player2Score = 0

        player1Y = 30
        player2Y = VIRTUAL_HEIGHT - 50
```

Aqui, criei um novo objeto de fonte que é de tamanho maior para que
possamos exibir a pontuação de cada jogador de forma mais visível na
tela e aloquei duas variáveis para fins de pontuação. As duas últimas
variáveis acompanharão a posição vertical de cada raquete, já que elas
se moverão para cima e para baixo.

-   Em seguida, você verá que finalmente defini esse comportamento em
    `love.update()`:

``` lua
        function love.update(dt)
            if love.keyboard.isDown('w') then
                player1Y = player1Y + -PADDLE_SPEED * dt
            elseif love.keyboard.isDown('s') then
                player1Y = player1Y + PADDLE_SPEED * dt
            end

            if love.keyboard.isDown('up') then
                player2Y = player2Y + -PADDLE_SPEED * dt
            elseif love.keyboard.isDown('down') then
                player2Y = player2Y + PADDLE_SPEED * dt
            end
        end
```

Aqui, implementei uma maneira para cada jogador mover sua raquete.
Lembre-se de que o sistema de coordenadas 2D está centralizado no canto
superior esquerdo da tela. Portanto, para que cada raquete se mova para
cima, sua posição Y precisará ser multiplicada pela velocidade negativa
(e vice-versa), o que pode parecer contra-intuitivo à primeira vista,
portanto, **reserve um momento para examinar isso com atenção.**

Existe um material que recomendo para uma compreensão rápida de álgebra
linear para games
[aqui](http://blog.wolfire.com/2009/07/linear-algebra-for-game-developers-part-1/)
(mas recomendo que se aprofunde! Vai por mim, vai te ajudar muito!).

-   Por último, em `love.draw()`você verá que adicionei algumas linhas
    para exibir a pontuação na tela:

``` lua
        love.graphics.setFont(scoreFont)
        love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
        love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
```

Primeiro, definimos a fonte ativa para ser a maior das duas que criamos
e, em seguida, exibimos a pontuação de cada jogador em seu lado da tela.

## pong-4 - Atualização da bola

-   pong-4 Adiciona movimento à bola quando o usuário pressiona `enter`.

### Funções Importantes

-   `math.randomseed(num)`
    -   Uma função da biblioteca padrão de Lua (`math.random`) que
        "semeia" um gerador de números aleatórios com alguns valores de
        forma que sua aleatoriedade dependa do valor fornecido,
        permitindo-nos passar diferentes números em cada jogada para
        garantir a não consistência entre as diferentes execuções do
        programa (ou uniformidade se quisermos um comportamento
        consistente para o teste).
-   `os.time()`
    -   Esta também é uma função da biblioteca padrão de Lua. Retorna,
        em segundos, o horário desde 00:00:00 UTC, de 1º de janeiro de
        1970, também conhecido como [Unix epoch time](https://en.wikipedia.ord/wiki/Unix_time).
-   `math.random(min, max)`
    -   Esta função retorna um número aleatório, dependente do gerador
        de número aleatório propagado, entre `min`e `max`, inclusive.
-   `math.min(num1, num2)`
    -   Retorna o menor dos dois números passados.
-   `math.max(num1, num2)`
    -   Retorna o maior dos dois números passados.

### Código Importante

-   Você encontrará a primeira adição ao código no início de
    `love.load()`:
```lua
        math.randomseed(os.time())
```


Isso semeia o gerador de números aleatórios, usando a hora atual
    para garantir números aleatórios diferentes a cada vez que o jogo é
    executado. Além disso, você verá algumas novas variáveis perto do
    final do `love.load()`:

   ``` lua
        ballX = VIRTUAL_WIDTH / 2 - 2
        ballY = VIRTUAL_HEIGHT / 2 - 2

        ballDX = math.random(2) == 1 and 100 or -100
        ballDY = math.random(-50, 50)

        gameState = 'start'

 ```

  
  `ballX` e `ballY` manterá o controle da posição da bola, enquanto
    `ballDX` e `ballDY` irá acompanhar a velocidade da bola.
    `gameState`servirá como uma "[State
    Machine](https://gameprogrammingpatterns.com/state.html)"
    rudimentar, que controlará os diferentes estados do jogo (iniciar,
    jogar, etc.)

-   Em `love.update()`, ajustamos nosso código para o movimento da
    raquete envolvendo-o em torno das funções `math.max()` e `math.min`
    para garantir que elas não se movam além das bordas da tela.

-   Também adicionei um novo código para garantir que a bola só possa se
    mover quando estamos no estado "play":

    ``` lua
        if gameState == 'play' then
            ballX = ballX + ballDX * dt
            ballY = ballY + ballDY * dt
        end
    ```

-   Depois disso, em `love.keypressed(key)`, adicionei a funcionalidade
    para iniciar o jogo (fazendo a transição do estado "start" para o
    estado de "play") e implementei a mecânica de movimento da bola:

    ``` lua
        elseif key == 'enter' or key == 'return' then
            if gameState == 'start' then
                gameState = 'play'
            else
                gameState = 'start'

                ballX = VIRTUAL_WIDTH / 2 - 2
                ballY = VIRTUAL_HEIGHT / 2 - 2

                ballDX = math.random(2) == 1 and 100 or -100
                ballDY = math.random(-50, 50) * 1.5
            end
        end
    ```

    Uma vez no "estado de jogo", começamos com a posição da bola no
    centro da tela e atribuímos a ela uma velocidade inicial aleatória.

-   Por último, ajustei a função `love.draw()` para que possamos ver as
    mudanças de `love.update()`em cada quadro:

    ``` lua
        if gameState == 'start' then
            love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
        else
            love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
        end

        love.graphics.rectangle('fill', 10, player1Y, 5, 20)
        love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)
        love.graphics.rectangle('fill', ballX, ballY, 4, 4)
    ```

    As únicas mudanças dignas de nota aqui são a exibição de mensagens
    diferentes, dependendo do estado do jogo, e a atualização das
    instruções de impressão anteriores para usar as variáveis que
    controlam dinamicamente a posição, em vez de valores estáticos.

## pong-5 - A atualização da Classe

-   pong-5 Se comporta exatamente como pong-4. A maior vantagem que
    ganhamos com esta atualização está no design do nosso código.
-   Abra o pong-5 para dar uma olhada em como reorganizei o código
    usando classes e objetos.

### O que é uma Classe?

-   Uma classe é essencialmente um contêiner para atributos (valores ou
    campos) e métodos (ou, funções). Você pode pensar nisso como um
    projeto para a criação de pacotes de dados e código que estão
    relacionados entre si.
-   Ex: uma classe "Carro" pode ter "atributos" que descrevem sua marca,
    modelo, cor, e qualquer outra coisa descritiva. Da mesma forma, uma
    classe "Carro" também pode ter "métodos" que definem seu
    comportamento, como "acelerar", "virar", "buzinar", que assumem a
    forma de funções.
-   Os objetos são instanciados a partir desses projetos de classe, e
    são esses objetos concretos que são os "carros" físicos que você vê
    na estrada, em oposição aos projetos que podem existir na fábrica.
-   As Raquetes e a Bola são casos de uso simples e perfeitos para pegar
    parte de nosso código e agrupá-lo em classes e objetos.
-   Em Lua, os nomes de arquivo de classe são capitalizados por
    convenção, o que ajuda a diferenciar entre quaisquer classes e
    bibliotecas que você possa incluir no mesmo diretório do arquivo
    `main.lua`.
-   Observe que temos que chamar os arquivos de classes com a função
    `require` em `main.lua` assim como fazemos com as bibliotecas. Além
    disso, usamos aqui uma biblioteca `class` que contém funcionalidades
    úteis para programação orientada a objetos em Lua (Lua tem uma
    maneira especifica de fazer POO, que considero um tanto complicada,
    essa biblioteca torna as coisas mais intuitivas. Semelhante a
    maneira que faríamos em Python, por exemplo).

### Código Importante

-   A principal lição desta atualização é que agora abstraímos de
    `main.lua` a lógica relevante para a mecânica das raquetes e da
    bola. Agora, eles estão em suas próprias classes, portanto, você
    verá alguns novos arquivos no diretório do projeto. `Ball.lua`
    contém toda a lógica específica da bola, enquanto `Paddle.lua`
    contém toda a lógica específica para cada Raquete. Você também
    encontrará `class.lua` que é o que me permitiu fazer isso.

-   Isso não só dará maior flexibilidade no futuro, mas também torna
    `main.lua` mais limpo e legível.

## pong-6 - A atualização do FPS

-   pong-6 Adiciona um título e exibe o FPS do nosso aplicativo na tela.

### Funções Importantes

-   `love.window.setTitle(title)`
    -   Esta função define o título da janela do nosso aplicativo,
        adicionando um leve nível de polimento.
-   `love.timer.getFPS()`
    -   Retorna o FPS atual (quadros por segundo) de nosso aplicativo,
        facilitando o monitoramento quando impresso.

### Código Importante

-   A primeira adição ao código está em `love.load()`:

    ``` lua
        love.window.setTitle('Pong')
    ```

    Esta linha rápida e fácil define o título de janela.

-   A segunda adição ao código está na parte inferior do arquivo
    `main.lua`. Defini uma função auxiliar para exibir o FPS na tela:

    ``` lua
        function displayFPS()
            love.graphics.setFont(smallFont)
            love.graphics.setColor(0, 255/255, 0, 255/255)
            love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
        end
    ```

    Em seguida, chamei essa função auxiliar em `love.draw()`.

## pong-7 - A atualização da colisão

-   pong-7 Permite que a bola rebata nas raquetes e nos limites da
    janela.

-   Abra o pong-7 para dar uma olhada em como incorporei a detecção de
    colisão AABB em nosso programa Pong.

Aqui está uma série de links que me foram muito úteis para entender o
conceito de colisão AABB

-   [Dynamic AABB
    Tree](http://www.randygaul.net/2013/08/06/dynamic-aabb-tree/)
-   [Game Physics: Broadphase Dynamic AABB
    Tree](http://allenchou.net/2014/02/game-physics-broadphase-dynamic-aabb-tree/)
-   [AABB.cc](http://aabb.cc/)
-   [Box2D](https://github.com/erincatto/Box2D)
-   [Introductory Guide to AABB Tree Collision
    Detection](https://www.azurefromthetrenches.com/introductory-guide-to-aabb-tree-collision-detection/)

### Detecção de colisão AABB

-   A detecção de colisão AABB depende de todas as entidades em colisão
    com "caixas delimitadoras alinhadas ao eixo", o que nos permite usar
    uma fórmula matemática simples para testar a colisão:

        if rect1.x is not > rect2.x + rect2.width and
            rect1.x + rect1.width is not < rect2.x and
            rect1.y is not > rect2.y + rect2.height and
            rect1.y + rect1.height is not < rect2.y:
            collision is true
        else
            collision is false

    Essencialmente, essa fórmula está checando se as duas caixas estão
    colidindo de alguma forma.

-   Podemos usar a detecção de colisão AABB para detectar se a bola está
    colidindo com as raquetes e reagir de acordo.

-   Sendo assim, podemos adaptar essa lógica para detectar se a bola
    colide com o limite da janela.

### Código Importante

-   Observe como adicionei uma função `collides` para a classe Ball. Ela
    usa o algoritmo acima para determinar se houve uma colisão,
    retornando `true` se sim e, caso contrário, `false`.

-   Podemos usar esta função em `love.update()`para acompanhar a mudança
    de posição e velocidade da bola após cada colisão com uma raquete:

    ``` lua
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
    ```

    Observe como primeiro *afasto* a bola da raquete, antes de inverter
    sua direção, se detectarmos que as bordas da bola e as da raquete se
    sobrepõem! Isso evita um loop infinito de colisão entre a bola e a
    raquete.

-   Também implementei lógica semelhante para colisões com as bordas da
    janela:

    ``` lua
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy
        end
    ```

## pong-8 - A atualização da pontuação

-   pong-8 Nos permite acompanhar a pontuação.

### Código Importante

-   Essencialmente, tudo o que precisamos fazer é incrementar as
    variáveis de pontuação de cada jogador sempre que a bola colide com
    o limite do gol:

    ``` lua
        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1
            ball:reset()
            gameState = 'start'
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1
            ball:reset()
            gameState = 'start'
        end
    ```

## pong-9 - A atualização do saque

-   pong-9 Introduz um novo estado, "serve", ao jogo.

### O que é uma máquina de estado?

-   Até agora falamos pouco sobre o *estado* em nosso programa. Temos
    nosso estado "start", o que significa que o jogo está pronto para
    começar ao pressionarmos "enter". Então, a bola começa a se mover,
    mudando o estado para "play", o que significa que o jogo está em
    andamento.
-   Uma máquina de estado se preocupa em monitorar qual é o estado atual
    e quais transições ocorrem entre os estados possíveis, de forma que
    cada estado individual seja produzido por uma transição específica e
    tenha sua própria lógica.
-   No pong-9, permitimos que um jogador possa "sacar" a bola não tendo
    que defender durante o primeiro turno.
-   Fazemos a transição do estado de "play" para o estado de "serve" e
    do estado de "serve" para o estado de "play" pressionando `enter`. O
    jogo começa no estado "start" e faz a transição para o estado de
    saque pressionando `enter`.

### Código Importante

-   Podemos essencialmente adicionar nosso novo estado de "serve"
    criando uma condição adicional na função\`love.update():

    ``` lua
        if gameState == 'serve' then
            ball.dy = math.random(-50, 50)
            if servingPlayer == 1 then
                ball.dx = math.random(140, 200)
            else
                ball.dx = -math.random(140, 200)
            end
        elseif ...
    ```

    A ideia é que quando um jogador faz o gol, ele deva sacar para não
    estar imediatamente na defesa. Fazemos isso ajustando a velocidade
    da bola no estado de "serve" com base no jogador que está sacando.

## pong-10 - Atualização da Vitória

-   pong-10 Permite que um jogador ganhe o jogo.

### Código Importante

-   Introduzi um novo estado: "done". E, em seguida, defini uma
    pontuação máxima (no caso, 10). Dentro de `love.update()`,
    modifiquei o código que verifica se um ponto foi marcado. Assim:

    ``` lua
        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1

            if player2Score == 10 then
                winningPlayer = 2
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1

            if player1Score == 10 then
                winningPlayer = 1
                gameState = 'done'
            else
                gameState = 'serve'
                ball:reset()
            end
        end
    ```

-   Quando um jogador atinge a pontuação máxima, o estado do jogo muda
    para "done" e produzimos uma tela de vitória em `love.draw()`:

    ``` lua
        elseif gameState == 'done' then
            love.graphics.setFont(largeFont)
            love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!', 0, 10, VIRTUAL_WIDTH, 'center')
            love.graphics.setFont(smallFont)
            love.graphics.printf('Press Enter to restart!', 0, 30, VIRTUAL_WIDTH, 'center')
        end
    ```

-   Finalmente, adicionei algumas linhas para `love.keypressed(key` que
    fazem voltar ao estado "serve" e zeram as pontuações caso o(s)
    jogador(es) queiram jogar novamente.

    ``` lua
        elseif key == 'enter' or key == 'return' then
            ...
            elseif gameState == 'done' then
                gameState = 'serve'

                ball:reset()

                player1Score = 0
                player2Score = 0

                if winningPlayer == 1 then
                    servingPlayer = 2
                else
                    servingPlayer = 1
                end
            end
        end
    ```

## pong-11 - A atualização de áudio

-   pong-11 Adiciona som ao jogo.

### Funções Importantes

-   `love.audio.newSource(path, [type])`
    -   Esta função cria um objeto LÖVE2D Audio que podemos reproduzir
        em qualquer ponto do programa. Também pode ser atribuído um
        "type" de "stream" ou "static"; assets transmitidos serão
        transmitidos do disco conforme necessário, enquanto assets
        estáticos serão preservados na memória. Para efeitos sonoros e
        faixas de música maiores, o streaming é mais eficaz para a
        memória; nesse exemplo, os assets de áudio são estáticos, pois
        são tão pequenos que não ocupam muita memória.
    -   Usaremos essa funcionalidade para reproduzir um som sempre que
        houver uma colisão.

### O que é LMMS?

O LMMS, ou Linux Multimedia Studio é um software livre multiplataforma
que lhe permite produzir música e efeitos sonoros. Ele cobre desde a
tarefa de criar melodias e batidas, até sintetizar e misturar sons e
organizar amostras.

-   Usei para gerar todos os efeitos sonoros do exemplo Pong e a maioria
    dos outros exemplos futuros.
-   <https://lmms.io/lsp/index.php>
-   Criei 3 arquivos de som e os armazenei em um subdiretório dentro do
    pong-11.

### Código Importante

-   Você notará em `love.load()`que crie uma tabela com referências aos
    3 arquivos de som que adicionei ao diretório do projeto:
```lua

        sounds = {
            ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
            ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
            ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
        }
```

-  Neste caso, armazenei cada som como um arquivo de áudio
     "estático" devido ao seu tamanho pequeno. No futuro, se estiver
      usando arquivos de áudio maiores, você pode considerar
    armazená-los como arquivos de "fluxo" de áudio para salvá-los na
        memória.
    -   Você deve ser capaz de encontrar no resto do `main.lua` as
        chamadas de função como `sounds['paddle_hit']:play()`em locais
        correspondentes para tocar som em colisões com as
        raquetes,parede e pontuação.

## pong-12 - A atualização de redimensionamento

-   pong-12 Permite que Pong suporte o redimensionamento da janela.

### Funções Importantes

-   `love.resize(width, height)`
    -   Esta função é chamada pelo LÖVE toda vez que redimensionamos a
        aplicação; a lógica deve entrar aqui se alguma coisa no jogo
        (como uma UI) for dimensionada dinamicamente com base no tamanho
        da janela. `push:resize()` precisa ser chamado aqui para que
        possa redimensionar dinamicamente sua tela interna afim de se
        ajustar às novas dimensões da janela.

### Código Importante

-   Para suportar o redimensionamento da janela do jogo, primeiro
    precisaremos editar a inicialização de janela em `love.load()`de tal
    modo que `resizable = true`:

    ``` lua
        push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
            fullscreen = false,
            resizable = true,
            vsync = true
        })
    ```

-   A próxima etapa é sobrescrever `love.resize()`com seu análogo da
    biblioteca `push`:

    ``` lua
        function love.resize(w, h)
            push:resize(w, h)
        end
    ```

E com isso, temos um jogo de Pong em pleno funcionamento!

# Conclusão:

Com esse programa simples que simula um dos jogos mais famosos de todos
os tempos, conseguimos analisar pontos básicos e fundamentais do
desenvolvimento de jogos. 

Passamos por conceitos como DeltaTime, State
Machine, Detecção de Colisão, Interpolação de imagem e um pouco de
Álgebra Linear para computação gráfica. 

Também vimos como definir o escopo de um projeto e implementar
esses conceitos em linguagem Lua, uma linguagem amplamente utilizada no desenvolvimento de games, fácil de aprender,
leve e rápida como o game engine Löve2D, que nos permite uma experiência
completa para prototipar jogos em duas dimensões. 

Espero que tenha se
divertido!
