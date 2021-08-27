# O que você encontrará neste repositório?

Aqui eu compartilharei alguns projetos que desenvolvo em Lua.

É um repositório de estudos, portanto, sinta-se a vontade para sugerir
melhorias e compartilhar ideias!

## Como clonar os subdiretórios:

Esse repositório trará diversos projetos divididos em outros
subdiretórios. É provável que você não precise clonar todos os arquivos,
mas apenas aqueles que te interessam.

Uma maneira simples de clonar um repositório específico é fazendo um
sparse checkout: Vamos supor que você queira clonar apenas o projeto
"pong", dentro de "lua-game":

-   crie uma pasta para o *pong* e dentro dela inicie uma sessão do git.

-   depois adicione o repositório remoto

``` bash
    $ mkdir pong 
    $ cd pong
    $ git init
    $ git remote add -f https://github.com/DVths/lua-projects.git
```

-   Isso cria um repositório remoto vazio e busca todos os objetos, mas
    não os verifica. Então faça:

``` bash
    $ git config core.sparseCheckout true
```

-   Agora defina quais arquivos/pastas você deseja fazer check-out. Isso
    é feito listando-os em .git/info/sparse-checkout, por exemplo:

``` bash
    $ echo "lua-game/pong/" >> .git/info/sparse-checkout
```

-   Finalmente, atualize seu repositório vazio com o estado do
    repositório remoto:

``` bash
    $ git pull origin main
```
