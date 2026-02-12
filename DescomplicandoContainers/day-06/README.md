# Descomplicando Containers - DAY-06


- [Descomplicando Containers - DAY-06](#descomplicando-containers---day-06)
- [Docker Swarm](#docker-swarm)
  - [Criando o nosso *cluster*!](#criando-o-nosso-cluster)
  - [O sensacional *services*!](#o-sensacional-services)
- [Docker Secrets](#docker-secrets)
  - [O comando *docker secret*](#o-comando-docker-secret)
  - [Tudo bem, mas como uso isso?](#tudo-bem-mas-como-uso-isso)
  - [Acessando a *secret*](#acessando-a-secret)
  - [Atualizando a *secret* de um serviço](#atualizando-a-secret-de-um-serviço)
- [Docker Compose](#docker-compose)
  - [O comando *docker stack*](#o-comando-docker-stack)
  - [E já acabou? :(](#e-já-acabou-)


# Docker Swarm

Bom, agora temos uma ferramenta muito interessante e que nos permite
construir *clusters* de *containers* de forma nativa e com extrema
facilidade, como já é de costume com os produtos criados pelo time do
Docker. ;)

Com o Docker Swarm você consegue construir *clusters* de *containers*
com características importantes como balanceador de cargas e *failover*.

Para criar um *cluster* com o Docker Swarm, basta indicar quais os
*hosts* que ele irá supervisionar e o restante é com ele.

Por exemplo, quando você for criar um novo *container*, ele irá criá-lo
no *host* que possuir a menor carga, ou seja, cuidará do balanceamento
de carga e garantirá sempre que o *container* será criado no melhor
*host* disponível no momento.

A estrutura de *cluster* do Docker Swarm é bastante simples e se resume
a um *manager* e diversos *workers*. O *manager* é o responsável por
orquestrar os *containers* e distribuí-los entre os *hosts workers*. Os
*workers* são os que carregam o piano, que hospedam os *containers*.

## Criando o nosso *cluster*!

Uma coisa importante que começou após a versão 1.12 foi a inclusão do
Docker Swarm dentro do Docker, ou seja, hoje quando você realiza a
instalação do Docker, automaticamente você está instalando o Docker
Swarm, que nada mais é do que uma forma de orquestrar seus *containers*
através da criação de um *cluster* com alta disponibilidade,
balanceamento de carga e comunicação criptografada, tudo isso nativo,
sem qualquer esforço ou dificuldade.

Para o nosso cenário, vamos utilizar três máquinas Ubuntu. A ideia é
fazer com que tenhamos dois *managers* e 1 *worker*.

Precisamos ter sempre mais do que um *node* representando o *manager*,
pois, se ficarmos sem *manager*, nosso *cluster* estará totalmente
indisponível.

Com isso temos o seguinte cenário:

-   **LINUXtips-01** -- *Manager* ativo.

-   **LINUXtips-02** -- *Manager*.

-   **LINUXtips-03** -- *Worker*.

Não precisa falar que precisamos ter o Docker instalado em todas essas
máquinas, certo, amiguinho? :D

Para iniciar, vamos executar o seguinte comando na "LINUXtips-01":

```bash
root@linuxtips-01:~# docker swarm init
Swarm initialized: current node (2qacv429fvnret8v09fqmjm16) is now a manager.

To add a worker to this swarm, run the following command:

   docker swarm join --token SWMTKN-1-100qtga34hfnf14xdbbhtv8ut6ugcvuhsx427jtzwaw1td2otj-18wccykydxte59gch2pix 172.31.58.90:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

root@linuxtips-01:~#
```

Com o comando anterior, iniciamos o nosso *cluster*!

Repare no seguinte trecho da saída do último comando:

```bash
# docker swarm join --token SWMTKN-1-100qtga34hfnf14xdbbhtv8ut6ugcvuhsx427jtzwaw1td2otj-18wccykydxte59gch2pix 172.31.58.90:2377
```

Essa linha nada mais é do que toda informação que você precisa para
adicionar *workers* ao seu *cluster*! Como assim?

Simples: o que você precisa agora é executar exatamente esse comando na
próxima máquina que você deseja incluir no *cluster* como *worker*!
Simples como voar, não?

De acordo com o nosso plano, a única máquina que seria *worker* é a
máquina "LINUXtips-03", correto? Então vamos acessá-la e executar
exatamente a linha de comando recomendada na saída do "docker swarm
init".

```bash
root@linuxtips-03:~# docker swarm join --token SWMTKN-1-100qtga34hfnf14xdbbhtv8ut6ugcvuhsx427jtzwaw1td2otj-18wccykydxte59gch2pix 172.31.58.90:2377
This node joined a swarm as a worker.

root@linuxtips-03:~#
```

Maravilha! Mais um *node* adicionado ao *cluster*!

Para que você possa ver quais os *nodes* que existem no *cluster*, basta
digitar o seguinte comando no ***manager* ativo**:

```bash
root@linuxtips-01:~# docker node ls
ID             HOSTNAME       STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
2qac           LINUXtips-01   Ready     Active         Leader           18.03.1-ce
nmxl           LINUXtips-03   Ready     Active                          18.03.1-ce

root@linuxtips-01:~#
```

Como podemos notar na saída do comando, temos dois *nodes* em nosso
*cluster*, um como *manager* e outro como *worker*. A coluna "MANAGER
STATUS" traz a informação de quem é o "Leader", ou seja, quem é o nosso
*manager*.

Em nosso plano nós teríamos dois *managers*, correto?

Agora a pergunta é: como eu sei qual é o *token* que preciso utilizar
para adicionar mais um *node* em meu *cluster*, porém dessa vez como
outro *manager*?

Lembra que, quando executamos o comando para adicionar o *worker* ao
*cluster*, nós tínhamos no comando um *token*? Pois bem, esse *token* é
quem define se o *node* será um *worker* ou um *manager*, e naquela
saída ele nos trouxe somente o *token* para adicionarmos *workers*.

Para que possamos visualizar o comando e o *token* referente aos
*managers*, precisamos executar o seguinte comando no *manager* ativo:

```bash
root@linuxtips-01:~# docker swarm join-token manager
To add a manager to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-100qtga34hfnf14xdbbhtv8ut6ugcvuhsx427jtzwaw1td2otj-3i4jsv4i70odu1mes0ebe1l1e 172.31.58.90:2377 

root@linuxtips-01:~#
```

Para visualizar o comando e o *token* referente aos *workers*:

```bash
root@linuxtips-01:~# docker swarm join-token worker
To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-100qtga34hfnf14xdbbhtv8ut6ugcvuhsx427jtzwaw1td2otj-18wccykydxte59gch2pixq9av 172.31.58.90:2377 

root@linuxtips-01:~#
```

Fácil, não?

Agora o que precisamos é executar na "LINUXtips-02" o comando para
inclusão de mais um *node* como *manager*. Portanto, execute:

```bash
root@linuxtips-02:~# docker swarm join --token SWMTKN-1-100qtga34hfnf14xdbbhtv8ut6ugcvuhsx427jtzwaw1td2otj-3i4jsv4i70odu1mes0ebe1l1e 172.31.58.90:2377

This node joined a swarm as a manager.

root@linuxtips-02:~#
```

Pronto! Agora temos o nosso *cluster* completo com dois *managers* e um
*worker*!

Vamos visualizar os *nodes* que fazem parte de nosso *cluster*.
Lembre-se: qualquer comando para administração do *cluster* ou criação
de serviços deverá obrigatoriamente ser executado no *manager* ativo,
sempre!

```bash
root@linuxtips-01:~# docker node ls
ID             HOSTNAME       STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
2qac           LINUXtips-01   Ready     Active         Leader           18.03.1-ce
j6lm           LINUXtips-02   Ready     Active         Reachable        18.03.1-ce
nmxl           LINUXtips-03   Ready     Active                          18.03.1-ce

root@linuxtips-01:~#
```

Perceba que o "MANAGER STATUS" da "LINUXtips-02" é "Reachable". Isso
indica que ela é um *manager*, porém não é o *manager* ativo, que sempre
carrega o "MANAGER STATUS" como "Leader".

Se nós quisermos saber detalhes sobre determinado *node*, podemos usar o
subcomando "inspect":

```bash
root@linuxtips-01:~# docker node inspect LINUXtips-02
[
    {
        "ID": "x3fuo6tdaqjyjl549r3lu0vbj",
        "Version": {
            "Index": 27
        },
        "CreatedAt": "2017-06-09T18:09:48.925847118Z",
        "UpdatedAt": "2017-06-09T18:09:49.053416781Z",
        "Spec": {
            "Labels": {},
            "Role": "worker",
            "Availability": "active"
        },
        "Description": {
            "Hostname": "LINUXtips-02",
            "Platform": {
                "Architecture": "x86_64",
                "OS": "linux"
            },
            "Resources": {
                "NanoCPUs": 1000000000,
                "MemoryBytes": 1038807040
            },
            "Engine": {
                "EngineVersion": "17.05.0-ce",
                "Plugins": [
                    {
                        "Type": "Network",
                        "Name": "bridge"
                    },
                    {
                        "Type": "Network",
                        "Name": "host"
                    },
                    {
                        "Type": "Network",
                        "Name": "null"
                    },
                    {
                        "Type": "Network",
                        "Name": "overlay"
                    },
                    {
                        "Type": "Volume",
                        "Name": "local"
                    }
                ]
            }
        },
        "Status": {
            "State": "ready",
            "Addr": "172.31.53.23"
        }
    }
]

root@linuxtips-01:~#
```

E se nós quisermos promover um *node worker* para *manager*, como
devemos fazer? Simples como voar, confira a seguir:

```bash
root@linuxtips-01:~# docker node promote LINUXtips-03
Node LINUXtips-03 promoted to a manager in the swarm.

root@linuxtips-01:~# docker node ls
ID             HOSTNAME       STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
2qac           LINUXtips-01   Ready     Active         Leader           18.03.1-ce
j6lm           LINUXtips-02   Ready     Active         Reachable        18.03.1-ce
nmxl           LINUXtips-03   Ready    Active          Reachable        18.03.1-ce

root@linuxtips-01:~#
```

Se quiser tornar um *node manager* em *worker*, faça:

```bash
root@linuxtips-01:~# docker node demote LINUXtips-03
Node LINUXtips-03 demoted to a manager in the swarm.
```

Vamos conferir:

```bash
root@linuxtips-01:~# docker node ls

ID             HOSTNAME       STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
2qac           LINUXtips-01   Ready     Active         Leader           18.03.1-ce
j6lm           LINUXtips-02   Ready     Active         Reachable        18.03.1-ce
nmxl           LINUXtips-03   Ready     Active                          18.03.1-ce

root@linuxtips-01:~#
```

Agora, caso você queira remover um *node* do *cluster*, basta digitar o
seguinte comando no *node* desejado:

```bash
root@linuxtips-03:~# docker swarm leave
Node left the swarm.

root@linuxtips-03:~#
```

E precisamos ainda executar o comando de remoção desse *node* também em
nosso *manager* ativo da seguinte forma:

```bash
root@linuxtips-01:~# docker node rm LINUXtips-03
LINUXtips-03

root@linuxtips-01:~#
```

Com isso, podemos executar o "docker node ls" e constatar que o *node*
foi realmente removido do *cluster*. Caso queira adicioná-lo novamente,
basta repetir o processo que foi utilizado para adicioná-lo, está
lembrado? :D

Para remover um *node* *manager* de nosso *cluster*, precisamos
adicionar a *flag* "\--force" ao comando "docker swarm leave", como
mostrado a seguir:

```bash
root@linuxtips-02:~# docker swarm leave --force
Node left the swarm.

root@linuxtips-02:~#
```

Agora, basta removê-lo também em nosso *node manager*:

```bash
root@linuxtips-01:~# docker node rm LINUXtips-02
LINUXtips-02

root@linuxtips-01:~#
```

## O sensacional *services*!

Uma das melhores coisas que o Docker Swarm nos oferece é justamente a
possibilidade de fazer o uso dos *services*.

O *services* nada mais é do que um VIP ou DNS que realizará o
balanceamento de requisições entre os *containers*. Podemos estabelecer
um número x de *containers* respondendo por um *service* e esses
*containers* estarão espalhados pelo nosso *cluster*, entre nossos
*nodes*, garantindo alta disponibilidade e balanceamento de carga, tudo
isso nativamente!

O *services* é uma forma, já utilizada no Kubernetes, de você conseguir
gerenciar melhor seus *containers*, focando no serviço que esses
*containers* estão oferecendo e garantindo alta disponibilidade e
balanceamento de carga. É uma maneira muito simples e efetiva para
escalar seu ambiente, aumentando ou diminuindo a quantidade de
*containers* que responderá para um determinado *service*.

Meio confuso? Sim eu sei, mas vai ficar fácil. :)

Imagine que precisamos disponibilizar o serviço do Nginx para ser o novo
*web server*. Antes de criar esse *service*, precisamos de algumas
informações:

-   Nome do *service* que desejo criar 
    >**webserver**.

-   Quantidade de *containers* que desejo debaixo do *service* 
    > **5**.

-   Portas que iremos "bindar", entre o *service* e o *node* 
    > **8080:80**.

-   Imagem dos *containers* que irei utilizar 
    > **nginx**.

Agora que já temos essas informações, 'bora criar o nosso primeiro
service. :)

```bash
root@linuxtips-01:~# docker service create --name webserver --replicas 5 -p 8080:80 nginx
0azz4psgfpkf0i5i3mbfdiptk

root@linuxtips-01:~#
```

Agora já temos o nosso *service* criado. Para testá-lo, basta executar:

```bash
root@linuxtips-01:~# curl QUALQUER_IP_NODES_CLUSTER:8080
```

O resultado do comando anterior lhe trará a página de boas-vindas do
Nginx.

Como estamos utilizando o *services*, cada conexão cairá em um
*container* diferente, fazendo assim o balanceamento de cargas
"automagicamente"!

Para visualizar o *service* criado, execute:

```bash
root@linuxtips-01:~# docker service ls
ID       NAME      MODE           REPLICAS   IMAGE         PORTS
0azz4p   webserver replicated     5/5        nginx:lates   *:8080->80/tcp
```

Conforme podemos notar, temos o *service* criado e com ele cinco
réplicas em execução, ou seja, cinco *containers* em execução.

Se quisermos saber onde estão rodando nossos *containers*, em quais
*nodes* eles estão sendo executados, basta digitar o seguinte comando:

```bash
root@linuxtips-01:~# docker service ps webserver
ID       NAME          IMAGE          NODE           DESIRED STATE  CURRENT STATE              ERROR     PORTS
zbt1j    webserver.1   nginx:latest   LINUXtips-01   Running        Running 8 minutes ago
iqm9p    webserver.2   nginx:latest   LINUXtips-02   Running        Running 8 minutes ago
jliht    webserver.3   nginx:latest   LINUXtips-01   Running        Running 8 minutes ago
qcfth    webserver.4   nginx:latest   LINUXtips-03   Running        Running 8 minutes ago
e17um    webserver.5   nginx:latest   LINUXtips-02   Running        Running 8 minutes ago

root@linuxtips-01:~#
```

Assim conseguimos saber onde está rodando cada *container* e ainda o seu
*status*.

Se eu preciso saber maiores detalhes sobre o meu *service*, basta
utilizar o subcomando "inspect".

```bash
root@linuxtips-01:~# docker service inspect webserver
[
    {
        "ID": "0azz4psgfpkf0i5i3mbfdiptk",
        "Version": {
            "Index": 29
        },
        "CreatedAt": "2017-06-09T19:35:58.180235688Z",
        "UpdatedAt": "2017-06-09T19:35:58.18899891Z",
        "Spec": {
            "Name": "webserver",
            "Labels": {},
            "TaskTemplate": {
                "ContainerSpec": {
                    "Image": "nginx:latest@sha256:41ad9967ea448d7c2b203c699b429abe1ed5af331cd92533900c6d77490e0268",
                    "StopGracePeriod": 10000000000,
                    "DNSConfig": {}
                },
                "Resources": {
                    "Limits": {},
                    "Reservations": {}
                },
                "RestartPolicy": {
                    "Condition": "any",
                    "Delay": 5000000000,
                    "MaxAttempts": 0
                },
                "Placement": {},
                "ForceUpdate": 0
            },
            "Mode": {
                "Replicated": {
                    "Replicas": 5
                }
            },
            "UpdateConfig": {
                "Parallelism": 1,
                "FailureAction": "pause",
                "Monitor": 5000000000,
                "MaxFailureRatio": 0,
                "Order": "stop-first"
            },
            "RollbackConfig": {
                "Parallelism": 1,
                "FailureAction": "pause",
                "Monitor": 5000000000,
                "MaxFailureRatio": 0,
                "Order": "stop-first"
            },
            "EndpointSpec": {
                "Mode": "vip",
                "Ports": [
                    {
                        "Protocol": "tcp",
                        "TargetPort": 80,
                        "PublishedPort": 8080,
                        "PublishMode": "ingress"
                    }
                ]
            }
        },
        "Endpoint": {
            "Spec": {
                "Mode": "vip",
                "Ports": [
                    {
                        "Protocol": "tcp",
                        "TargetPort": 80,
                        "PublishedPort": 8080,
                        "PublishMode": "ingress"
                    }
                ]
            },
            "Ports": [
                {
                    "Protocol": "tcp",
                    "TargetPort": 80,
                    "PublishedPort": 8080,
                    "PublishMode": "ingress"
                }
            ],
            "VirtualIPs": [
                {
                    "NetworkID": "89t2aobeik8j7jcre8lxhj04l",
                    "Addr": "10.255.0.5/16"
                }
            ]
        }
    }
]

root@linuxtips-01:~#
```

Na saída do "inspect" conseguiremos pegar informações importantes sobre
nosso *service*, como portas expostas, volumes, *containers*,
limitações, entre outras coisas.

Uma informação muito importante é o endereço do VIP do *service*:

```json
    "VirtualIPs": [
        {
            "NetworkID": "89t2aobeik8j7jcre8lxhj04l",
            "Addr": "10.255.0.5/16"
        }
    ]
```

Esse é o endereço IP do "balanceador" desse *service*, ou seja, sempre
que acessarem via esse IP, ele distribuirá a conexão entre os
*containers*. Simples, não?

Agora, se quisermos aumentar o número de *containers* debaixo desse
*service*, é muito simples. Basta executar o comando a seguir:

```bash
root@linuxtips-01:~# docker service scale webserver=10
webserver scaled to 10

root@linuxtips-01:~#
```

Pronto, simples assim!

Agora já temos dez *containers* respondendo requisições debaixo do nosso
*service* *webserver*! Simples como voar!

Para visualizar, basta executar:

```bash
root@linuxtips-01:~# docker service ls
ID      NAME      MODE        REPLICAS   IMAGE           PORTS
0azz    webserver replicated  10/10      nginx:latest    *:8080->80/tcp

root@linuxtips-01:~#
```

Para saber em quais *nodes* eles estão em execução, lembre-se do "docker
service ls webserver".

Para acessar os *logs* desse *service*, basta digitar:

```bash
root@linuxtips-01:~# docker service logs -f webserver
webserver.5.e17umj6u6bix@LINUXtips-02 | 10.255.0.2 - - [09/Jun/2017:19:36:12 +0000] "GET / HTTP/1.1" 200 612 "-" "curl/7.47.0" "-"
```

Assim, você terá acesso aos *logs* de todos os *containers* desse
*service*. Muito prático!

"Cansei de brincar! Quero remover esse meu *service*!" É tão simples
quanto criá-lo. Digite:

```bash
root@linuxtips-01:~# docker service rm webserver
webserver

root@linuxtips-01:~#
```

Pronto! Seu *service* foi excluído e você pode conferir na saída do
comando a seguir:

```bash
root@linuxtips-01:~# docker service ls
ID      NAME      MODE        REPLICAS   IMAGE           PORTS

root@linuxtips-01:~#
```

Criar um *service* com um volume conectado é bastante simples. Faça:

```bash
root@linuxtips-01:~# docker service create --name webserver --replicas 5 -p 8080:80 --mount type=volume,src=teste,dst=/app nginx
yfheu3k7b8u4d92jemglnteqa

root@linuxtips-01:~#
```

Quando eu crio um *service* com um volume conectado a ele, isso indica
que esse volume estará disponível em todos os meus *containers* desse
*service*, ou seja, o volume com o nome de "teste" estará montado em
todos os *containers* no diretório "/app"*.*


# Docker Secrets

Ninguém tem dúvida de que a arquitetura de microsserviços já se provou
eficiente. Porém, implementar segurança, principalmente em um contexto
de infraestrutura imutável, tem sido um belo desafio.

Com questões que envolvem desde como separar a senha do *template* em
uma imagem até como trocar a senha de acesso a um serviço sem
interrompê-lo, *workarounds* não faltam. Mas como sempre dá para
melhorar, na versão 1.13 nossos queridos amigos do Docker lançaram o que
foi chamado de Docker Secrets.

O Docker Secrets é a solução do Docker para trabalhar com toda a parte
de *secrets* em um ambiente *multi-node* e *multi-container.* Em outras
palavras, um *"swarm mode" cluster*. A *secret* pode conter qualquer
coisa, porém deve ter um tamanho máximo de 500 KB. Por enquanto essa
belezinha não está disponível fora do contexto do Docker Swarm -- na
verdade, não é claro se vai algum dia ser diferente. Por enquanto somos
encorajados a usar um *service* para fazer *deploy* de *containers*
individuais.

## O comando *docker secret*

O comando "docker secret" vem com alguns subcomandos. São eles:

```bash
docker secret --help

Usage: docker secret COMMAND

Manage Docker secrets

Options:
     --help Print usage

Commands:
    create   Create a secret from a file or STDIN as content
    inspect  Display detailed information on one or more secrets
    ls       List secrets
    rm       Remove one or more secrets

Run 'docker secret COMMAND --help' for more information on a command.
```

-   **create** -- Cria uma *secret* a partir do conteúdo de um arquivo ou STDIN.

-   **inspect** -- Mostra informações detalhadas de uma ou mais *secrets*.

-   **ls** -- Lista as *secrets* existentes.

-   **rm** -- Remove uma ou mais *secrets*.

**Create**

Como dito, o "create" aceita conteúdo tanto do STDIN\...

```bash
root@linuxtips:~# echo 'minha secret' | docker secret create minha_secret -
jxr0pilzhtqsiqi1f1fjmmg4t

root@linuxtips:~#
```

...quanto de um arquivo:

```bash
root@linuxtips:~# docker secret create minha_secret minha_secret.txt
ci7mse43i5ak378sg3qc4xt04

root@linuxtips:~#
```

**Inspect**

Fique tranquilo, o "inspect" não mostra o conteúdo da sua *secret*! :P

Em vez disso, ele mostra uma série de informações sobre a *secret*,
incluindo sua criação e modificação (apesar de não ter, na verdade, como
modificar uma *secret*; uma vez criada, ela não pode ser atualizada via
CLI, porém já há um *endpoint* na API do Docker Swarm para *update* de
*secret* -- "/secrets/{id}/update", vamos aguardar!)

```bash
root@linuxtips:~# docker secret inspect minha_secret
[
    {
        "ID": "ci7mse43i5ak378sg3qc4xt04",
        "Version": {
            "Index": 808
        },
        "CreatedAt": "2017-07-02T17:17:18.143116694Z",
        "UpdatedAt": "2017-07-02T17:17:18.143116694Z",
        "Spec": {
            "Name": "minha_secret",
            "Labels": {}
        }
    }
]

root@linuxtips:~#
```

O "inspect" aceita mais de uma *secret* por vez e mostrará o resultado
na mesma sequência.

**ls && rm**

Servem respectivamente para listar suas *secrets* e removê-las.

```bash
root@linuxtips:~# docker secret ls
ID                         NAME           CREATED             UPDATED
ci7mse43i5ak378sg3qc4xt04  minha_secret   About a minute ago  About a minute ago

root@linuxtips:~#
root@linuxtips:~# docker secret rm minha_secret
minha_secret

root@linuxtips:~#
```

## Tudo bem, mas como uso isso?

As *secrets* são consumidas por serviços, como já citamos, e isso
acontece através de associação explícita, usando a *flag* "\--secret" na
hora de criar um serviço. Vamos para um exemplo.

Primeiro vamos criar uma *secret* com a senha do banco de dados da nossa
aplicação *fake.*

```bash
root@linuxtips:~# echo 'senha_do_banco' | docker secret create db_pass -
kxzgmhlu3ytv64hbqzg30nc8u

root@linuxtips:~#
```

Agora, vamos associá-la à nossa *app*, criando um serviço.

```bash
root@linuxtips:~# docker service create --name app --detach=false --secret db_pass minha_app:1.0
npfmry3vcol61cmcql3jiljk2
overall progress: 1 out of 1 tasks
1/1: running [==================================================>]
verify: Waiting 1 seconds to verify that tasks are stable...

root@linuxtips:~# docker service ls
ID            NAME      MODE        REPLICAS   IMAGE           PORTS
npfmry3vcol6  app       replicated  1/1        minha_app:1.0

root@linuxtips:~# docker container ls
CONTAINER ID     IMAGE          COMMAND                   CREATED           STATUS           PORTS     NAMES
65d1533f5b50     minha_app:1.0  "/bin/sh -c ./scri..."   40 seconds ago     Up 39 seconds              app.1.molbmj0649c7xkzfermkuwrx2

root@linuxtips:~#
```

Também é possível dar acesso a *keys* para serviços já criados, através
da *flag* "\--secret-add" do comando "docker service update", assim como
revogá-las, usando a *flag* "\--secret-rm" no mesmo comando. Ver o
tópico "Atualizando a *secret* de um serviço".

## Acessando a *secret*

Com o serviço criado, a *secret* ficará disponível para todos os
*containers* daquele *service* e estará em arquivos dentro do diretório
"/run/secrets", montado em *tmpfs*. Se a sua *secret* chamar "db\_pass",
como no exemplo, o conteúdo dela estará em "/run/secrets/db\_pass".

É possível incluir alguns parâmetros na hora de adicionar uma *secret* a
um serviço, como, por exemplo, o *target*, que altera o nome do arquivo
no destino e até itens de segurança, como *uid*, *gid* e *mode*:

docker service create \--detach=false \--name app \--secret
source=db\_pass,target=password,uid=2000,gid=3000,mode=0400
minha\_app:1.0

Dentro do *container* ficaria assim:

```bash
root@4dd6b9cbff1a:/app# ls -lhart /run/secrets/
total 12K
-r-------- 1 2000 3000   15 Jul 2 17:44 password
drwxr-xr-x 7 root root 4.0K Jul 2 17:44 ..
drwxr-xr-x 2 root root 4.0K Jul 2 17:44 .

root@4dd6b9cbff1a:/app#
```

E aí basta que a sua aplicação leia o conteúdo do arquivo.

```bash
root@8b16b5335334:/app# python
Python 2.7.12 (default, Nov 19 2016, 06:48:10)
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>>
>>> secret = open('/run/secrets/password').read()
>>>
>>> print "minha secret e: %s" % (secret)
minha secret e: nova_senha
>>>
```

## Atualizando a *secret* de um serviço

*Secrets* foram criadas para serem imutáveis, ou seja, caso você queira
trocar a *secret* de um serviço, você precisará criar outra *secret*. A
troca da *secret* é bem fácil. Por exemplo, para trocar a *secret*
"db\_pass" do exemplo anterior, teríamos que fazer o seguinte:

Criar uma nova *secret*:

```bash
root@linuxtips:~# echo 'nova_senha' | docker secret create db_pass_1 -
221uzilbsl1ybna7g7014hoqr

root@linuxtips:~#
```

Adicionar à *secret* a *app* criada anteriormente:

```bash
root@linuxtips:~# docker service update --secret-rm db_pass --detach=false --secret-add source=db_pass_1,target=password app
app
overall progress: 1 out of 1 tasks
1/1: running [==================================================>]
verify: Waiting 1 seconds to verify that tasks are stable...

root@linuxtips:~#
```

Após a atualização, basta remover a *secret* antiga:

```bash
root@linuxtips:~# docker secret rm db_pass
db_pass

root@linuxtips:~#
```


# Docker Compose

Bem, agora chegamos em uma das partes mais importantes do livro, o
sensacional e completo Docker Compose!

O Docker Compose nada mais é do que uma forma de você conseguir escrever
em um único arquivo todos os detalhes do ambiente de sua aplicação.
Antes nós usávamos o *dockerfile* apenas para criar imagens, seja da
minha aplicação, do meu BD ou do meu *webserver*, mas sempre de forma
unitária, pois tenho um *dockerfile* para cada "tipo" de *container*: um
para a minha *app*, outro para o meu BD e assim por diante.

Com o Docker Compose nós falamos sobre o ambiente inteiro. Por exemplo,
no Docker Compose nós definimos quais os *services* que desejamos criar
e quais as características de cada *service* (quantidade de *containers*
debaixo daquele *service*, volumes, *network*, *secrets*, etc.).

O padrão que os *compose files* seguem é o YML, supersimples e de fácil
entendimento, porém sempre é bom ficar ligado na sintaxe que o padrão
YML lhe impõe. ;)

Bem, vamos parar de falar e começar a brincadeira!

Antes a gente precisava instalar o Docker Compose para utilizá-lo.
Porém, hoje nós temos o subcomando "docker stack", já disponível junto à
instalação do Docker. Ele é responsável por realizar o *deploy* de
nossos *services* através do Docker Compose de maneira simples, rápida e
muito efetiva.

'Bora começar! A primeira coisa que devemos realizar é a própria criação
do *compose file*. Vamos começar por um mais simples e vamos aumentando
a complexidade conforme evoluímos.

Lembre-se: para que possamos seguir com os próximos exemplos, o seu
*cluster* *swarm* deverá estar funcionando perfeitamente. Portanto, se
ainda não estiver com o *swarm* ativo, execute:

```bash
# docker swarm init
```

Vamos criar um diretório chamado "Composes", somente para que possamos
organizar melhor nossos arquivos.

```bash
# mkdir /root/Composes
# mkdir /root/Composes/1
# cd /root/Composes/1
# vim docker-compose.yml
```

```yaml
version: "3"

services:
    web:
        image: nginx
        deploy:
        replicas: 5
        resources:
        limits:
            cpus: "0.1"
            memory: 50M
        restart_policy:
            condition: on-failure
        ports:
        - "8080:80"
        networks:
        - webserver

networks:
    webserver:
```

Pronto! Agora já temos o nosso primeiro *docker-compose*. O que
precisamos agora é realizar o *deploy*, porém antes vamos conhecer
algumas opções que utilizamos anteriormente:

-   **version: \"3\" --** Versão do *compose* que estamos utilizando.

-   **services:** -- Início da definição de meu serviço.

-   **web: *--*** Nome do serviço.

-   **image: nginx** -- Imagem que vamos utilizar.

-   **deploy: --** Início da estratégia de *deploy*.

-   **replicas: 5** -- Quantidade de réplicas.

-   **resources:** -- Início da estratégia de utilização de recursos.

-   **limits:** -- Limites.

-   **cpus: \"0.1\"** -- Limite de CPU.

-   **memory: 50M** -- Limite de memória.

-   **restart\_policy:** -- Políticas de *restart*.

-   **condition: on-failure** -- Somente irá "restartar" o *container* em caso de falha.

-   **ports:** -- Quais portas desejamos expor.

-   **- \"8080:80\"** -- Portas expostas e "bindadas".

-   **networks:** -- Definição das redes que irei utilizar nesse serviço.

-   ***-* webserver** -- Nome da rede desse serviço.

-   **networks:** -- Declarando as redes que usaremos nesse *docker-compose*.

-   **webserver:** -- Nome da rede a ser criada, caso não exista.

Simples como voar, não? :D

## O comando *docker stack*

Agora precisamos realizar o *deploy* desse *service* através do *compose
file* que criamos. Para isso, vamos utilizar o sensacional "docker
stack":

```bash
root@linuxtips-01:~/Composes/1# docker stack deploy -c docker-compose.yml primeiro
Creating network primeiro_webserver
Creating service primeiro_web

root@linuxtips-01:~/Composes/1#
```

Simples assim, e nosso service já está disponível para uso. Agora vamos
verificar se realmente o *service* subiu e se está respondendo conforme
esperado:

```bash
root@linuxtips-01:~/Composes/1# curl 0:8080
<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to nginx!</title>
        <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
        </style>
    </head>
    <body>
        <h1>Welcome to nginx!</h1>
        <p>If you see this page, the nginx web server is successfully installed and working. Further configuration is required.</p>
        <p>For online documentation and support please refer to
        <a href="http://nginx.org/">nginx.org</a>.<br/>
        Commercial support is available at
        <a href="http://nginx.com/">nginx.com</a>.</p>
        <p><em>Thank you for using nginx.</em></p>
    </body>
</html>

root@linuxtips-01:~/Composes/1#
```

Sensacional, o nosso *service* está em pé, pois recebemos a página de
boas-vindas do Nginx!

Vamos verificar se está tudo certo com o *service*:

```bash
root@linuxtips-01:~/Composes/1# docker service ls
ID     NAME          MODE        REPLICAS    IMAGE           PORTS
mw95t  primeiro_web  replicated  5/5         nginx:latest    *:8080->80/tcp

root@linuxtips-01:~/Composes/1# docker service ps primeiro_web
ID            NAME             IMAGE         NODE           DESIRED STATE   CURRENT STATE           ERROR   PORTS
lrcqo8ifultq  primeiro_web.1   nginx:latest  LINUXtips-02   Running         Running 2 minutes ago
ty16mkcqdwyl  primeiro_web.2   nginx:latest  LINUXtips-03   Running         Running 2 minutes ago
dv670shw22o2  primeiro_web.3   nginx:latest  LINUXtips-01   Running         Running 2 minutes ago
sp0k1tnjftnr  primeiro_web.4   nginx:latest  LINUXtips-01   Running         Running 2 minutes ago
4fpl35llq1ih  primeiro_web.5   nginx:latest  LINUXtips-03   Running         Running 2 minutes ago

root@linuxtips-01:~/Composes/1#
```

Para listar todos os *stacks* criados, basta executar:

```bash
root@linuxtips-01:~/Composes/1# docker stack ls
NAME        SERVICES
primeiro    1

root@linuxtips-01:~/Composes/1#
```

Perceba: a saída diz que possuímos somente um *stack* criado e esse
*stack* possui um *service*, que é exatamente o nosso do Nginx.

Para visualizar os *services* que existem em determinado *stack*,
execute:

```bash
root@linuxtips-01:~/Composes/1# docker stack services primeiro
ID            NAME          MODE         REPLICAS   IMAGE          PORTS
mx0p4vbrzfuj  primeiro_web  replicated   5/5        nginx:latest   *:8080->80/tcp

root@linuxtips-01:~/Composes/1#
```

Podemos verificar os detalhes do nosso *stack* criado através do comando
a seguir:

```bash
root@linuxtips-01:~/Composes/1# docker stack ps primeiro
ID             NAME             IMAGE          NODE           DESIRED STATE    CURRENT STATE            ERROR   PORTS
x3u03509w9u3   primeiro_web.1   nginx:latest   LINUXtips-03   Running          Running 5 seconds ago
3hpu5lo6yvld   primeiro_web.2   nginx:latest   LINUXtips-02   Running          Running 5 seconds ago
m82wbwuwoza0   primeiro_web.3   nginx:latest   LINUXtips-03   Running          Running 5 seconds ago
y7vizedqvust   primeiro_web.4   nginx:latest   LINUXtips-02   Running          Running 5 seconds ago
wk0acjnyl6jm   primeiro_web.5   nginx:latest   LINUXtips-01   Running          Running 5 seconds ago

root@linuxtips-01:~/Composes/1#
```

Maravilha! Nosso *service* está *UP* e tudo está em paz!

Em poucos minutos subimos o nosso *service* do Nginx em nosso *cluster*
utilizando o *docker-compose* e o "docker stack", simples como voar!

Agora vamos imaginar que eu queira remover esse meu *service*. Como eu
faço? Simples:

```bash
root@linuxtips-01:~/Composes/1# docker stack rm primeiro
Removing service primeiro_web
Removing network primeiro_webserver

root@linuxtips-01:~/Composes/1#
```

Para verificar se realmente removeu o *service*:

```bash
root@linuxtips-01:~/Composes/1# docker service ls
ID    NAME    MODE     REPLICAS     IMAGE     PORTS

root@linuxtips-01:~/Composes/1#
```

Pronto! Nosso *service* está removido!

Vamos aumentar um pouco a complexidade na criação de nosso
*docker-compose* nesse novo exemplo.

Vamos criar mais um diretório, onde criaremos o nosso novo *compose
file*:

```bash
root@linuxtips-01:~/Composes# mkdir 2
root@linuxtips-01:~/Composes# cd 2
root@linuxtips-01:~/Composes# vim docker-compose.yml
```

```yaml
version: '3'
    services:
        db:
            image: mysql:5.7
            volumes:
                - db_data:/var/lib/mysql
            environment:
                MYSQL_ROOT_PASSWORD: somewordpress
                MYSQL_DATABASE: wordpress
                MYSQL_USER: wordpress
                MYSQL_PASSWORD: wordpress

        wordpress:
            depends_on:
            - db
            image: wordpress:latest
            ports:
            - "8000:80"
            environment:
                WORDPRESS_DB_HOST: db:3306
                WORDPRESS_DB_USER: wordpress
                WORDPRESS_DB_PASSWORD: wordpress

volumes:
    db_data:
```

Perfeito!

Nesse exemplo estamos conhecendo mais algumas opções que podemos
utilizar no *docker-compose*. São eles:

-   **volumes:** -- Definição dos volumes utilizados pelo *service*.

-   **- db\_data:/var/lib/mysql** -- Volume e destino.

-   **environment:** -- Definição de variáveis de ambiente utilizados pelo *service.*

-   **MYSQL\_ROOT\_PASSWORD: somewordpress** -- Variável e valor.

-   **MYSQL\_DATABASE: wordpress** -- Variável e valor.

-   **MYSQL\_USER: wordpress** -- Variável e valor.

-   **MYSQL\_PASSWORD: wordpress** -- Variável e valor.

-   **depends\_on:** -- Indica que esse *service* depende de outro para subir.

-   **- db** -- Nome do service que necessário para sua execução.

Muito simples, não?!?

Agora vamos realizar o *deploy* desse exemplo. Como se pode perceber, o
nosso *stack* é composto por dois *services*, o Wordpress e o MySQL.

```bash
root@linuxtips-01:~/Composes/2# docker stack deploy -c docker-compose.yml segundo
Creating network segundo_default
Creating service segundo_db
Creating service segundo_wordpress

root@linuxtips-01:~/Composes/2#
```

Conforme esperado, ele realizou a criação dos dois *services* e da rede
do *stack*.

Para acessar o seu Wordpress, basta acessar em um navegador:

***http://SEU\_IP:8000***

Seu Wordpress está pronto para uso!

Para verificar se correu tudo bem com os *services*, lembre-se dos
comandos:

```bash
root@linuxtips-01:~/Composes/1# docker stack ls
root@linuxtips-01:~/Composes/1# docker stack services segundo
root@linuxtips-01:~/Composes/1# docker service ls
root@linuxtips-01:~/Composes/1# docker service ps segundo_db
root@linuxtips-01:~/Composes/1# docker service ps segundo_wordpress
```

Para visualizar os *logs* de determinado *service*:

```bash
root@linuxtips-01:~/Composes/2# docker service logs segundo_wordpress
segundo_wordpress.1.r6reuq8fsil0@LINUXtips-01 | WordPress not found in /var/www/html - copying now...
segundo_wordpress.1.r6reuq8fsil0@LINUXtips-01 | Complete! WordPress has been successfully copied to /var/www/html
segundo_wordpress.1.r6reuq8fsil0@LINUXtips-01 | AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 10.0.4.5. Set the 'ServerName' directive globally to suppress this message
segundo_wordpress.1.r6reuq8fsil0@LINUXtips-01 | AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 10.0.4.5. Set the 'ServerName' directive globally to suppress this message
segundo_wordpress.1.r6reuq8fsil0@LINUXtips-01 | [Sun Jun 11 10:32:47.392836 2017] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.10 (Debian) PHP/5.6.30 configured -- resuming normal operations
segundo_wordpress.1.r6reuq8fsil0@LINUXtips-01 | [Sun Jun 11 10:32:47.392937 2017] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'

root@linuxtips-01:~/Composes/2#
```

E se for necessária uma modificação em meu *stack* e depois um
*re-deploy*, como eu faço? É possível?

Claro! Afinal, Docker é muita vida!

```bash
root@linuxtips-01:~/Composes# mkdir 3
root@linuxtips-01:~/Composes# cd 3
root@linuxtips-01:~/Composes/3# vim docker-compose.yml
```

```yaml
version: "3"
    services:
        web:
            image: nginx
            deploy:
                replicas: 5
            resources:
                limits:
                cpus: "0.1"
                memory: 50M
            restart_policy:
                condition: on-failure
            ports:
            - "8080:80"
            networks:
            - webserver
        
        visualizer:
            image: dockersamples/visualizer:stable
            ports:
            - "8888:8080"
            volumes:
            - "/var/run/docker.sock:/var/run/docker.sock"
            deploy:
                placement:
                    constraints: [node.role == manager]

    networks:
    - webserver

networks:
    webserver:
```

Perceba que apenas adicionamos um novo *service* ao nosso *stack*, o
*visualizer*. A ideia é realizar o *update* somente no *stack* para
adicionar o *visualizer*, sem deixar indisponível o *service* *web.*

Antes de realizarmos o *update* desse *stack*, vamos conhecer as novas
opções que estão no *compose file* desse exemplo:

**deploy:**

-   **placement:** -- Usado para definir a localização do nosso *service.*

-   **constraints: \[node.role == manager\]** -- Regra que obriga a criação desse *service* somente nos *nodes manager*.

Agora vamos atualizar o nosso *stack*:

```bash
root@linuxtips-01:~/Composes/3# docker stack deploy -c docker-compose.yml primeiro
Creating service primeiro_visualizer
Updating service primeiro_web (id: mx0p4vbrzfujk087c3xe2sjvo)

root@linuxtips-01:~/Composes/3#
```

Perceba que, para realizar o *update* do *stack*, utilizamos o mesmo
comando que usamos para realizar o primeiro *deploy* do *stack*, o
"docker stack deploy".

Que tal aumentar ainda mais a complexidade e o número de *services* de
um *stack*? 'Bora?

Para esse exemplo, vamos utilizar um projeto do próprio Docker
([https://github.com/dockersamples/example-voting-app](https://github.com/dockersamples/example-voting-app)),
onde teremos diversos *services*. Vamos criar mais um diretório para
receber o nosso projeto:

```bash
root@linuxtips-01:~/Composes# mkdir 4
root@linuxtips-01:~/Composes# cd 4
root@linuxtips-01:~/Composes/4# vim compose-file.yml
```

```yaml
version: "3"

services:
    redis:
        image: redis:alpine
        ports:
        - "6379"
        networks:
        - frontend
        deploy:
            replicas: 2
            update_config:
                parallelism: 2
                delay: 10s
            restart_policy:
                condition: on-failure
    
    db:
        image: postgres:9.4
        volumes:
        - db-data:/var/lib/postgresql/data
        networks:
        - backend
        deploy:
            placement:
                constraints: [node.role == manager]

    vote:
        image: dockersamples/examplevotingapp_vote:before
        ports:
        - 5000:80
        networks:
        - frontend
        depends_on:
        - redis
        deploy:
            replicas: 2
            update_config:
                parallelism: 2
            restart_policy:
                condition: on-failure
    
    result:
        image: dockersamples/examplevotingapp_result:before
        ports:
        - 5001:80
        networks:
        - backend
        depends_on:
        - db
        deploy:
            replicas: 1
            update_config:
                parallelism: 2
                delay: 10s
            restart_policy:
                condition: on-failure
        
    worker:
        image: dockersamples/examplevotingapp_worker
        networks:
        - frontend
        - backend
        deploy:
            mode: replicated
            replicas: 1
            labels: [APP=VOTING]
            restart_policy:
                condition: on-failure
                delay: 10s
                max_attempts: 3
                window: 120s
            placement:
                constraints: [node.role == manager]
    
    visualizer:
        image: dockersamples/visualizer:stable
        ports:
        - "8080:8080"
        stop_grace_period: 1m30s
        volumes:
            - "/var/run/docker.sock:/var/run/docker.sock"
        deploy:
            placement:
                constraints: [node.role == manager]
networks:
    frontend:
    backend:

volumes:
    db-data:
```

Ficou mais complexo ou não? Acho que não, pois no Docker tudo é bastante
simples!

Temos algumas novas opções nesse exemplo, vamos conhecê-las:

**deploy:**

-   **mode: replicated** -- Qual é o tipo de deployment? Temos dois, o *global* e o *replicated*. No *replicated* você escolhe a quantidade de réplicas do seu *service*, já no *global* você não escolhe a quantidade de réplicas, ele irá subir uma réplica por *node* de seu *cluster* (uma réplica em cada *node* de seu *cluster*).

**update\_config:**

-   **parallelism: 2** -- Como irão ocorrer os updates (no caso, de 2 em 2).

-   **delay: 10s** -- Com intervalo de 10 segundos.

**restart\_policy:**

-   **condition: on-failure** -- Em caso de falha, *restart.*

-   **delay: 10s** -- Com intervalo de 10 segundos.

-   **max\_attempts: 3** -- Com no máximo três tentativas.

-   **window: 120s** -- Tempo para definir se o *restart* do *container* ocorreu com sucesso.

Agora vamos realizar o *deploy* do nosso *stack*:

```bash
root@linuxtips-01:~/Composes/4# docker stack deploy -c docker-compose.yml quarto
Creating network quarto_default
Creating network quarto_frontend
Creating network quarto_backend
Creating service quarto_worker
Creating service quarto_visualizer
Creating service quarto_redis
Creating service quarto_db
Creating service quarto_vote
Creating service quarto_result

root@linuxtips-01:~/Composes/4#
```

Verificando os *services*:

```bash
root@linuxtips-01:~/Composes/4# docker service ls
ID            NAME               MODE       REPLICAS   IMAGE                                             PORTS
3hi3sx2on3t5  quarto_worker      replicated 1/1        dockersamples/examplevotingapp_worker:latest
hbsp4fdcvgnz  quarto_visualizer  replicated 1/1        dockersamples/visualizer:stable                   :8080->8080/tcp
k6xuqbq7g55a  quarto_db          replicated 1/1        postgres:9.4 
p2reijydxnsw  quarto_result      replicated 1/1        dockersamples/examplevotingapp_result:before      :5001->80/tcp
rtwnnkwftg9u  quarto_redis       replicated 2/2        redis:alpine                                      :0->6379/tcp
w2ritqiklpok  quarto_vote        replicated 2/2        dockersamples/examplevotingapp_vote:before        :5000->80/tcp

root@linuxtips-01:~/Composes/4#
```

Lembre-se de sempre utilizar os comandos que já conhecemos para
visualizar *stack*, *services*, volumes, *container*, etc.

Para acessar os services em execução, abra um navegador e vá aos
seguintes endereços:

-   **Visualizar a página de votação:** http://IP_CLUSTER:5000/

-   **Visualizar a página de resultados:** http://IP_CLUSTER:5001/

-   **Visualizar a página de com os *containers* e seus *nodes*:** http://IP_CLUSTER:8080/

Vamos para mais um exemplo. Agora vamos realizar o *deploy* de um
*stack* completo de monitoração para o nosso *cluster* e todas as demais
máquinas de nossa infraestrutura. Nesse exemplo vamos utilizar um
arquivo YML que realizará o *deploy* de diversos *containers* para que
possamos ter as seguintes ferramentas integradas:

-   **Prometheus** -- Para armazenar todas as métricas de nosso ambiente.

-   **cAdvisor** -- Para coletar informações dos *containers*.

-   **Node Exporter** -- Para coletar informações dos *nodes* do *cluster* e demais máquinas do ambiente.

-   **Netdata** -- Para coletar mais de 5 mil métricas de nossas máquinas, além de prover um *dashboard* sensacional.

-   **Rocket.Chat** -- Para que possamos nos comunicar com outros times e pessoas e também para integrá-lo ao sistema de monitoração, notificando quando os alertas acontecem. O Rocket.Chat é uma excelente alternativa ao Slack.

-   **AlertManager** -- Integrado ao Prometheus e ao Rocket.Chat, é o responsável por gerenciar nossos alertas.

-   **Grafana** -- Integrado à nossa solução de monitoração, ele é o responsável pelos *dashboards* que são produzidos através das métricas que estão armazenadas no Prometheus.

Com esse *stack* é possível monitorar *containers*, VMs e máquinas
físicas. Porém, o nosso foco agora é somente no que se refere ao livro e
a este capítulo, ou seja, as informações contidas no *compose file* que
definirão nosso *stack*.

Para maiores detalhes em relação ao *Giropops-Monitoring*, acesse o
repositório no endereço:
[https://github.com/badtuxx/giropops-monitoring](https://github.com/badtuxx/giropops-monitoring).

Antes de conhecer nosso *compose file*, precisamos realizar o clone do
projeto:

```bash
# git clone https://github.com/badtuxx/giropops-monitoring.git
```

Acesse o diretório "giropops-monitoring":

```bash
# cd giropops-monitoring
```

O nosso foco aqui será em três caras: o arquivo "grafana.config", o
diretório "conf" e o nosso querido e idolatrado "docker-compose.yml".

O arquivo "grafana.config" contém variáveis que queremos passar ao nosso
Grafana. Nesse momento a única informação importante é o *password* do
*admin*, usuário que utilizaremos para logar na interface web do
Grafana.

O diretório "conf" possui os arquivos necessários para que a integração
entre as aplicações de nosso *stack* funcionem corretamente.

Já o nosso *compose file* traz todas as informações necessárias para que
nós possamos realizar o *deploy* de nosso *stack*.

Como o nosso foco é o *compose file*, 'bora lá conhecê-lo!

```bash
# cat docker-compose.yml
version: '3.3'
services:
    prometheus:
        image: linuxtips/prometheus_alpine
        volumes:
        - ./conf/prometheus/:/etc/prometheus/
        - prometheus_data:/var/lib/prometheus
        networks:
        - backend
        ports:
        - 9090:9090

    node-exporter:
        image: linuxtips/node-exporter_alpine
        hostname: {% raw %}'{{.Node.ID}}'{% endraw %}
        volumes:
        - /proc:/usr/proc
        - /sys:/usr/sys
        - /:/rootfs
        deploy:
            mode: global
        networks:
        - backend
        ports:
        - 9100:9100

    alertmanager:
        image: linuxtips/alertmanager_alpine
        volumes:
        - ./conf/alertmanager/:/etc/alertmanager/
        networks:
        - backend
        ports:
        - 9093:9093

    cadvisor:
        image: google/cadvisor
        hostname: {% raw %}'{{.Node.ID}}'{% endraw %}
        volumes:
        - /:/rootfs:ro
        - /var/run:/var/run:rw
        - /sys:/sys:ro
        - /var/lib/docker/:/var/lib/docker:ro
        - /var/run/docker.sock:/var/run/docker.sock:ro
        networks:
        - backend
        deploy:
            mode: global
        ports:
        - 8080:8080

    grafana:
        image: nopp/grafana_alpine
        depends_on:
        - prometheus
        volumes:
        - ./conf/grafana/grafana.db:/grafana/data/grafana.db
        env_file:
        - grafana.config
        networks:
        - backend
        - frontend
        ports:
        - 3000:3000

    # If you already has a RocketChat instance running, just comment the code of rocketchat, mongo and mongo-init-replica services bellow
    rocketchat:
        image: rocketchat/rocket.chat:latest
        volumes:
        - rocket_uploads:/app/uploads
        environment:
        - PORT=3080
        - ROOT_URL=http://YOUR_IP:3080
        - MONGO_URL=mongodb://giropops_mongo:27017/rocketchat
        - MONGO_OPLOG_URL=mongodb://giropops_mongo:27017/local
        depends_on:
        - giropops_mongo
        ports:
        - 3080:3080

    mongo:
        image: mongo:3.2
        volumes:
        - mongodb_data:/data/db
        #- ./data/dump:/dump
        command: mongod --smallfiles --oplogSize 128 --replSet rs0
        mongo-init-replica:
        image: mongo:3.2
        command: 'mongo giropops_mongo/rocketchat --eval "rs.initiate({_id: ''rs0'', members: [ { _id: 0, host: ''localhost:27017''} ]})"'
        depends_on:
        - giropops_mongo

networks:
    frontend:
    backend:

volumes:
    prometheus_data:
    grafana_data:
    rocket_uploads:
    mongodb_data:
```

Perceba que já conhecemos todas as opções que estão nesse exemplo, nada
de novo. :D

O que precisamos agora é realizar o *deploy* de nosso *stack*:

```bash
# docker stack deploy -c docker-compose.yml giropops
Creating network giropops_backend
Creating network giropops_frontend
Creating network giropops_default
Creating service giropops_grafana
Creating service giropops_rocketchat
Creating service giropops_mongo
Creating service giropops_mongo-init-replica
Creating service giropops_prometheus
Creating service giropops_node-exporter
Creating service giropops_alertmanager
Creating service giropops_cadvisor
```

Caso queira verificar se os *services* estão em execução:

```bash
# docker service ls
```

Para listar os *stacks*:

```bash
# docker stack ls
```

Para acessar os serviços do quais acabamos de realizar o *deploy*, basta
acessar os seguintes endereços:

-   **Prometheus**: http://SEU_IP:9090

-   **AlertManager**: http://SEU_IP:9093

-   **Grafana**: http://SEU_IP:3000

-   **Node\_Exporter**: http://SEU_IP:9100

-   **Rocket.Chat:** http://SEU_IP:3080

-   **cAdivisor**: http://SEU_IP:8080

Para remover o *stack*:

```bash
# docker stack rm giropops
```

Lembrando: para conhecer mais sobre o *giropops-monitoring* acesse o
repositório no GitHub e assista à série de vídeos em que o Jeferson fala
detalhadamente como montou essa solução:

-   **Repo**:
    > [https://github.com/badtuxx/giropops-monitoring](https://github.com/badtuxx/giropops-monitoring)

-   **Vídeos**:
    > [https://www.youtube.com/playlist?list=PLf-O3X2-mxDls9uH8gyCQTnyXNMe10iml](https://www.youtube.com/playlist?list=PLf-O3X2-mxDls9uH8gyCQTnyXNMe10iml)

E assim termina a nossa jornada no mundo do Docker. Esperamos que você
tenha aprendido e, mais do que isso, tenha gostado de dividir esse tempo
conosco para falar sobre o que nós mais amamos, tecnologia!

## E já acabou? :(

Esperamos que você tenha curtido viajar conosco durante o seu
aprendizado sobre *containers* e principalmente sobre o ecossistema do
Docker, que é sensacional!

Não pare de aprender mais sobre Docker! Continue acompanhando o Canal
LinuxTips no [https://www.youtube.com/linuxtips](https://www.youtube.com/linuxtips)
e fique ligado no site do Docker, pois sempre tem novidades e ótima
documentação!

Junte-se a nós no Discord para que possa acompanhar e tirar dúvidas que
possam ter surgido durante seus estudos!

\#VAIIII