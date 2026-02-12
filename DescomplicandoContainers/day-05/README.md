# Descomplicando Containers - DAY-05

- [Descomplicando Containers - DAY-05](#descomplicando-containers---day-05)
- [Gerenciando a rede dos *containers*](#gerenciando-a-rede-dos-containers)
  - [Consigo fazer com que a porta do *container* responda na porta do *host*?](#consigo-fazer-com-que-a-porta-do-container-responda-na-porta-do-host)
  - [E como ele faz isso? Mágica?](#e-como-ele-faz-isso-mágica)
- [Tipos de rede no Docker](#tipos-de-rede-no-docker)
  - [Exemplos praticos com Dockerfiles](#exemplos-praticos-com-dockerfiles)
    - [bridge](#bridge)
    - [host](#host)
    - [none](#none)
    - [overlay (requer Swarm)](#overlay-requer-swarm)
    - [macvlan](#macvlan)
    - [ipvlan](#ipvlan)
- [Limitando CPU e Memória de Containers](#limitando-cpu-e-memória-de-containers)
  - [Limitando Memória](#limitando-memória)
  - [Limitando CPU](#limitando-cpu)
- [Controlando o *daemon* do Docker](#controlando-o-daemon-do-docker)
  - [O Docker sempre utiliza 172.16.X.X ou posso configurar outro intervalo de IP?](#o-docker-sempre-utiliza-17216xx-ou-posso-configurar-outro-intervalo-de-ip)
  - [Opções de *sockets*](#opções-de-sockets)
    - [*Unix Domain Socket*](#unix-domain-socket)
    - [TCP](#tcp)
  - [Opções de *storage*](#opções-de-storage)
  - [Opções de rede](#opções-de-rede)
  - [Opções diversas](#opções-diversas)
- [Docker Machine](#docker-machine)
  - [Ouvi dizer que minha vida ficaria melhor com o Docker Machine!](#ouvi-dizer-que-minha-vida-ficaria-melhor-com-o-docker-machine)
    - [Vamos instalar?](#vamos-instalar)
    - [Vamos iniciar nosso primeiro projeto?](#vamos-iniciar-nosso-primeiro-projeto)


# Gerenciando a rede dos *containers*

Quando o Docker é executado, ele cria uma *bridge* virtual chamada
"docker0", para que possa gerenciar a comunicação interna entre o
*container* e o *host* e também entre os *containers*.

Vamos conhecer alguns parâmetros do comando "Docker container run" que
irão nos ajudar com a rede em que os *containers* irão se comunicar.

-   **\--dns** -- Indica o servidor DNS.

-   **\--hostname** -- Indica um *hostname.*

-   **\--link** -- Cria um *link* entre os *containers*, sem a necessidade de se saber o IP um do outro. Opcao legada; prefira redes definidas pelo usuario e DNS interno do Docker.

-   **\--net** -- Permite configurar o modo de rede que você usara com o *container*. Voce pode usar drivers como bridge, host, none, overlay, macvlan e ipvlan, alem de redes definidas pelo usuario ou `container:<id>`.

-   **\--expose** -- Expõe a porta do *container* apenas.

-   **\--publish** -- Expõe a porta do *container* e do *host*.

-   **\--default-gateway** -- Determina a rota padrão.

-   **\--mac-address** -- Determina um MAC *address*.

Quando o *container* é iniciado, a rede passa por algumas etapas até a
sua inicialização completa:

1.  Cria-se um par de interfaces virtuais.

2.  Cria-se uma interface com nome único, como "veth1234", e em seguida *linka-se* com a *bridge* do Docker, a "docker0".

3.  Com isso, é disponibilizada a interface "eth0" dentro do *container*, em um *network namespace* único.

4.  Configura-se o MAC *address* da interface virtual do *container.*

5.  Aloca-se um IP na "eth0" do *container*. Esse IP tem que pertencer ao *range* da *bridge* "docker0"*.*

Com isso, o *container* já possui uma interface de rede e já está apto a
se comunicar com outros *containers* ou com o *host*. :D

## Consigo fazer com que a porta do *container* responda na porta do *host*?

Sim, isso é possível e bastante utilizado.

Vamos conhecer um pouco mais sobre isso em um exemplo utilizando aquela
nossa imagem "linuxtips/apache".

Primeira coisa que temos que saber é a porta pela qual o Apache2 se
comunica. Isso é fácil, né? Se estiver com as configurações padrões de
porta de um *web server*, o Apache2 do *container* estará respondendo na
porta 80/TCP, correto?

Agora vamos fazer com que a porta 8080 do nosso *host* responda pela
porta 80 do nosso *container*, ou seja, sempre que alguém bater na porta
8080 do nosso *host*, a requisição será encaminhada para a porta 80 do
*container*. Simples, né?

Para conseguir fazer esse encaminhamento, precisamos utilizar o
parâmetro "-p" do comando "docker container run", conforme faremos no
exemplo a seguir:

```bash
root@linuxtips:~# # docker container run -ti -p 8080:80 linuxtips/apache:1.0 /bin/bash
root@4a0645de6d94:/# ps -ef
UID   PID PPID C STIME TTY      TIME CMD
root    1    0 1 18:18 ?    00:00:00 /bin/bash
root    6    1 0 18:18 ?    00:00:00 ps -ef

root@4a0645de6d94:/# /etc/init.d/apache2 start
[....] Starting web server: apache2AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.3. Set the 'ServerName' directive globally to suppress this message
. ok

root@4a0645de6d94:/# ps -ef
UID       PID PPID C STIME TTY        TIME CMD
root        1    0 0 18:18 ?      00:00:00 /bin/bash
root       30    1 0 18:19 ?      00:00:00 /usr/sbin/apache2 -k start
www-data   33   30 0 18:19 ?      00:00:00 /usr/sbin/apache2 -k start
www-data   34   30 0 18:19 ?      00:00:00 /usr/sbin/apache2 -k start
root      109    1 0 18:19 ?      00:00:00 ps -ef

root@4a0645de6d94:/# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
             valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
             valid_lft forever preferred_lft forever
74: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
        link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff
        inet 172.17.0.3/16 scope global eth0
             valid_lft forever preferred_lft forever
        inet6 fe80::42:acff:fe11:3/64 scope link
             valid_lft forever preferred_lft forever

root@4a0645de6d94:/#
```

Repare que passamos o parâmetro "-p" da seguinte forma:

-   **-p 8080:80** -- Onde "8080" é a porta do host e "80" a do container.

Com isso, estamos dizendo que toda requisição que chegar na porta 8080
do meu *host* deverá ser encaminhada para a porta 80 do *container.*

Já no *container*, subimos o Apache2 e verificamos o IP do *container*,
correto?

Agora vamos sair do *container* com o atalho "Ctrl + p + q". :)

A partir do *host*, vamos realizar um "curl" com destino ao IP do
*container* na porta 80, depois com destino à porta 8080 do *host* e em
seguida analisar as saídas:

```bash
root@linuxtips:~# curl <IPCONTAINER>:80
```

Se tudo ocorreu bem até aqui, você verá o código da página de
boas-vindas do Apache2.

O mesmo ocorre quando executamos o "curl" novamente, porém batendo no IP
do *host*. Veja:

```bash
root@linuxtips:~# curl <IPHOST>:8080
```

Muito fácil, chega a ser lacrimejante! \\o/

## E como ele faz isso? Mágica?

Não, não é mágica! Na verdade, o comando apenas utiliza um módulo
bastante antigo do *kernel* do Linux chamado *netfilter*, que
disponibiliza a ferramenta *iptables*, que todos nós já cansamos de
usar.

Vamos dar uma olhada nas regras de *iptables* referentes a esse nosso
*container*. Primeiro a tabela *filter*:

```bash
root@linuxtips:~# iptables -L -n
Chain INPUT (policy ACCEPT)
target prot opt source destination

Chain FORWARD (policy ACCEPT)
target prot opt source destination
DOCKER-ISOLATION all -- 0.0.0.0/0 0.0.0.0/0
DOCKER all -- 0.0.0.0/0 0.0.0.0/0
ACCEPT all -- 0.0.0.0/0 0.0.0.0/0 ctstate RELATED,ESTABLISHED
ACCEPT all -- 0.0.0.0/0 0.0.0.0/0
ACCEPT all -- 0.0.0.0/0 0.0.0.0/0

Chain OUTPUT (policy ACCEPT)
target prot opt source destination

Chain DOCKER (1 references)
target prot opt source destination
ACCEPT tcp -- 0.0.0.0/0 172.17.0.2 tcp dpt:5000
ACCEPT tcp -- 0.0.0.0/0 172.17.0.3 tcp dpt:80

Chain DOCKER-ISOLATION (1 references)
target prot opt source destination
RETURN all -- 0.0.0.0/0 0.0.0.0/0

root@linuxtips:~#
```

Agora a tabela NAT:

```bash
root@linuxtips:~# iptables -L -n -t nat

Chain PREROUTING (policy ACCEPT)
target prot opt source destination
DOCKER all -- 0.0.0.0/0 0.0.0.0/0 ADDRTYPE match dst-type LOCAL

Chain INPUT (policy ACCEPT)
target prot opt source destination

Chain OUTPUT (policy ACCEPT)
target prot opt source destination
DOCKER all -- 0.0.0.0/0 !127.0.0.0/8 ADDRTYPE match dst-type LOCAL

Chain POSTROUTING (policy ACCEPT)
target prot opt source destination
MASQUERADE all -- 172.17.0.0/16 0.0.0.0/0
MASQUERADE tcp -- 172.17.0.2 172.17.0.2 tcp dpt:5000
MASQUERADE tcp -- 172.17.0.3 172.17.0.3 tcp dpt:80

Chain DOCKER (2 references)
target prot opt source destination
RETURN all -- 0.0.0.0/0 0.0.0.0/0
DNAT tcp -- 0.0.0.0/0 0.0.0.0/0 tcp dpt:5000 to:172.17.0.2:5000
DNAT tcp -- 0.0.0.0/0 0.0.0.0/0 tcp dpt:8080 to:172.17.0.3:80

root@linuxtips:~#
```

Como podemos notar, temos regras de NAT configuradas que permitem o DNAT
da porta 8080 do *host* para a 80 do *container.* Veja a seguir:

```bash
MASQUERADE tcp -- 172.17.0.3  172.17.0.3  tcp dpt:80
DNAT       tcp -- 0.0.0.0/0   0.0.0.0/0   tcp dpt:8080 to:172.17.0.3:80
```

Tudo isso feito "automagicamente" pelo Docker, sem a necessidade de
precisar configurar diversas regras de *iptables*. \<3


# Tipos de rede no Docker

O Docker oferece diferentes tipos de rede para atender necessidades
distintas. Cada tipo muda como o *container* se comunica com o *host*,
com outros *containers* e com o mundo externo.

-   **bridge** -- Padrao no Linux. Cria uma *bridge* virtual (como a
    "docker0") e conecta os *containers* nela. Permite comunicacao
    entre *containers* na mesma *bridge* e com o *host*. Para acesso
    externo, use *port mapping* com "-p".

-   **host** -- O *container* compartilha a pilha de rede do *host*.
    Nao ha isolamento de portas: o *container* usa as mesmas interfaces
    e portas do *host*. E util para reduzir *overhead* de rede. Funciona
    apenas em Linux; no Docker Desktop ha limitacoes.

-   **none** -- Desativa a rede do *container*. Apenas a interface
    *loopback* existe. Util para cenarios altamente restritos.

-   **overlay** -- Permite comunicacao entre *containers* em hosts
    diferentes, criando uma rede virtual distribuida. E comum em
    ambientes *Swarm* ou orquestracao multi-host.

-   **macvlan** -- Atribui um MAC unico ao *container*, fazendo-o
    aparecer como um dispositivo fisico na rede. O *container* recebe
    um IP da rede externa e pode ser acessado diretamente.

-   **ipvlan** -- Semelhante ao *macvlan*, mas com menos MACs na rede.
    O *container* compartilha o MAC da interface pai e recebe IP
    proprio. Ajuda em redes com limite de MACs.


Exemplos rapidos:

```bash
# bridge (padrao)
docker network create minha-bridge
docker container run --rm -d --network minha-bridge nginx

# host
docker container run --rm -d --network host nginx

# none
docker container run --rm -d --network none alpine sleep 3600
```


## Exemplos praticos com Dockerfiles

Os exemplos abaixo usam imagens simples para deixar claro o papel do
tipo de rede. Os Dockerfiles estao em:

-   [Dockerfile.bridge](network-examples/Dockerfile.bridge)
-   [Dockerfile.host](network-examples/Dockerfile.host)
-   [Dockerfile.none](network-examples/Dockerfile.none)
-   [Dockerfile.overlay](network-examples/Dockerfile.overlay)
-   [Dockerfile.macvlan](network-examples/Dockerfile.macvlan)
-   [Dockerfile.ipvlan](network-examples/Dockerfile.ipvlan)

### bridge

```bash
cd DescomplicandoContainers/day-05
docker build -f network-examples/Dockerfile.bridge -t dc-net-bridge .
docker network create dc-bridge
docker container run --rm -d --name web-bridge --network dc-bridge -p 8080:8080 dc-net-bridge
curl http://localhost:8080
```

### host

```bash
cd DescomplicandoContainers/day-05
docker build -f network-examples/Dockerfile.host -t dc-net-host .
docker container run --rm -d --name web-host --network host dc-net-host
curl http://localhost:8080
```

### none

```bash
cd DescomplicandoContainers/day-05
docker build -f network-examples/Dockerfile.none -t dc-net-none .
docker container run --rm -d --name web-none --network none dc-net-none
docker exec -it web-none ip addr
```

### overlay (requer Swarm)

```bash
cd DescomplicandoContainers/day-05
docker build -f network-examples/Dockerfile.overlay -t dc-net-overlay .
docker swarm init
docker network create -d overlay dc-overlay
docker service create --name web-overlay --network dc-overlay -p 8080:8080 dc-net-overlay
curl http://localhost:8080
```

### macvlan

```bash
cd DescomplicandoContainers/day-05
docker build -f network-examples/Dockerfile.macvlan -t dc-net-macvlan .
docker network create -d macvlan \
    --subnet 192.168.1.0/24 --gateway 192.168.1.1 \
    -o parent=eth0 dc-macvlan
docker container run --rm -d --name web-macvlan --network dc-macvlan dc-net-macvlan
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web-macvlan
```

Substitua `eth0`, `192.168.1.0/24` e `192.168.1.1` pela sua interface e pela subnet reais.

### ipvlan

```bash
cd DescomplicandoContainers/day-05
docker build -f network-examples/Dockerfile.ipvlan -t dc-net-ipvlan .
docker network create -d ipvlan \
    --subnet 192.168.1.0/24 --gateway 192.168.1.1 \
    -o parent=eth0 -o ipvlan_mode=l2 dc-ipvlan
docker container run --rm -d --name web-ipvlan --network dc-ipvlan dc-net-ipvlan
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web-ipvlan
```

Substitua `eth0`, `192.168.1.0/24` e `192.168.1.1` pela sua interface e pela subnet reais.


# Limitando CPU e Memória de Containers

Por padrão, um container tem acesso ilimitado aos recursos do *host*. Isso pode ser perigoso, pois um container mal comportado pode consumir toda a memória ou CPU da máquina, afetando outros containers e até o próprio sistema operacional.
Felizmente, o Docker nos permite limitar esses recursos de forma muito simples.

## Limitando Memória

Podemos limitar a quantidade de memória que um container pode usar. Se o container tentar usar mais memória do que o limite, ele pode ser morto pelo OOM Killer (Out Of Memory Killer) do Linux.

- **--memory (ou -m)**: Define o limite máximo de memória.
- **--memory-swap**: Define o limite de memória + swap.

Exemplo: Limitar o container a 512MB de memória RAM:

```bash
docker container run -d -m 512M --name meu-banco mysql
```

Se definirmos `--memory` e não definirmos `--memory-swap`, o container terá acesso a 512MB de RAM e 512MB de Swap (totalizando 1GB).
Para desativar o swap para o container, defina `--memory-swap` com o mesmo valor de `--memory`.

## Limitando CPU

Também podemos controlar quanto de CPU um container pode usar.

- **--cpus**: Especifica quanto de CPU o container pode usar. Por exemplo, 1.5 significa que o container pode usar um processador e meio.
- **--cpu-shares**: Define o peso (weight) do container em relação aos outros (padrão 1024). Útil para priorizar containers quando a CPU está saturada.
- **--cpuset-cpus**: Define quais núcleos (cores) o container pode usar (ex: 0-3).

Exemplo: Limitar o container a usar no maximo 50% de uma CPU:

```bash
docker container run -d --cpus 0.5 nginx
```

Exemplo: Forçar o container a rodar apenas no primeiro núcleo da CPU:

```bash
docker container run -d --cpuset-cpus 0 nginx
```

É muito importante definir esses limites em ambientes de produção para garantir a estabilidade do seu ambiente!


# Controlando o *daemon* do Docker

Antes de tudo, vamos tentar entender o que é um *daemon*. Sabemos que,
em sistemas operacionais *multitask*, isto é, em um sistema operacional
capaz de executar mais de uma tarefa por vez (*not really*), um *daemon*
é um software que roda de forma independente em *background*. Ele
executa certas ações predefinidas em resposta a certos eventos. Pois
bem, o *daemon* do Docker é exatamente isso: uma espécie de processo-pai
que controla tudo, *containers*, imagens, etc., etc., etc.

Até o Docker 1.7 as configurações referentes especificamente ao *daemon*
se confundiam bastante com configurações globais -- isso porque quando
você digitava lá o "docker -help" um monte de coisas retornava, e você
não sabia o que era o quê. A partir da versão 1.8 tivemos o "docker
daemon", e agora, mais recentemente, acreditamos que na versão 18.03 do
Docker, ele foi substituído pelo "dockerd", que resolve de vez esse
problema e trata especificamente de configurações referentes,
obviamente, ao *daemon* do Docker.

## O Docker sempre utiliza 172.16.X.X ou posso configurar outro intervalo de IP?

Sim, você pode configurar outro *range* para serem utilizados pela
*bridge* "docker0" e também pelas interfaces dos *containers*.

Para que você consiga configurar um *range* diferente para utilização do
Docker é necessário iniciá-lo com o parâmetro "\--bip".

```bash
# dockerd --bip 192.168.0.1/24
```

Assim, você estará informando ao Docker que deseja utilizar o IP
"192.168.0.1" para sua *bridge* "docker0" e, consequentemente, para a
*subnet* dos *containers*.

Você também poderá utilizar o parâmetro "\--fixed-cidr" para restringir
o *range* que o Docker irá utilizar para a *bridge* "docker0" e para a
*subnet* dos *containers*.

```bash
# dockerd --fixed-cidr 192.168.0.0/24
```

## Opções de *sockets*

*Sockets* são *end-points* com as quais duas ou mais aplicações ou
processos se comunicam em um ambiente, geralmente um "IP:porta" ou um
arquivo, como no caso do *Unix Domain Sockets*.

Atualmente o Docker consegue trabalhar com três tipos de *sockets*,
Unix, TCP e FD, e por *default* ele usa *unix sockets*. Você deve ter
notado que, ao *startar* seu Docker, foi criado um arquivo em
"/var/run/docker.sock". Para fazer alterações nele você vai precisar ou
de permissão de *root* ou de que o usuário que esteja executando as
ações faça parte do grupo "docker", como dissemos no começo deste livro,
lembra?

Por mais prático que isso seja, existem algumas limitações, como, por
exemplo, o *daemon* só poder ser acessado localmente. Para resolver isso
usamos geralmente o TCP. Nesse modelo nós definimos um IP, que pode ser
tanto "qualquer um" (0.0.0.0 e uma porta) como um IP específico e uma
porta.

Nos sistemas baseados em *systemd* você ainda pode se beneficiar do
*systemd socket activation*, uma tecnologia que visa economia de
recursos. Consiste basicamente em ativar um *socket* somente enquanto
uma conexão nova chega e desativar quando não está sendo mais usado.

Além disso tudo, dependendo do seu ambiente, você também pode fazer o
Docker escutar em diferentes tipos de *sockets*, o que é feito através
do parâmetro "-H" do comando "dockerd".

Exemplos:

### *Unix Domain Socket*

```bash
root@linuxtips:~# dockerd -H unix:///var/run/docker.sock
INFO[0000] [graphdriver] using prior storage driver "aufs"
INFO[0000] Graph migration to content-addressability took 0.00 seconds
INFO[0000] Firewalld running: false
INFO[0000] Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP
address
WARN[0000] Your kernel does not support swap memory limit.
INFO[0000] Loading containers: start.
..........................
INFO[0000] Loading containers: done.
INFO[0000] Daemon has completed initialization
INFO[0000] Docker daemon commit=c3959b1 execdriver=native-0.2 graphdriver=aufs version=1.10.2
INFO[0000] API listen on /var/run/docker.sock
```

### TCP

```bash
root@linuxtips:~# dockerd -H tcp://0.0.0.0:2375
WARN[0000] /! DON'T BIND ON ANY IP ADDRESS WITHOUT setting -tlsverify IF YOU DON'T KNOW WHAT YOU'RE DOING /!
INFO[0000] [graphdriver] using prior storage driver "aufs"
INFO[0000] Graph migration to content-addressability took 0.01 seconds
INFO[0000] Firewalld running: false
INFO[0000] Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP address
WARN[0000] Your kernel does not support swap memory limit.
INFO[0000] Loading containers: start.
..........................
INFO[0000] Loading containers: done.
INFO[0000] Daemon has completed initialization
INFO[0000] Docker daemon commit=c3959b1 execdriver=native-0.2 graphdriver=aufs version=1.10.2
INFO[0000] API listen on [::]:2375
```

## Opções de *storage*

Sendo o cara que controla tudo, naturalmente é possível passar opções
que mudam a forma como o Docker se comporta ao trabalhar com *storages*.
Como falamos anteriormente, o Docker suporta alguns *storage drivers*,
todos baseados no esquema de *layers*.

Essas opções são passadas para o *daemon* pelo parâmetro
"\--storage-opt", com o qual itens relacionados ao *Device Mapper*
recebem o prefixo "dm" e "zfs" para (adivinha?) o ZFS. A seguir vamos
demonstrar algumas opções mais comuns:

-   **dm.thinpooldev** -- Com esta opção você consegue especificar o *device* que será usado pelo *Device Mapper* para desenvolver o *thin-pool* que ele usa para criar os *snapshots* usados por *containers* e imagens.

Exemplo:

```bash
root@linuxtips:~# dockerd --storage-opt dm.thinpooldev=/dev/mapper/thin-pool
INFO[0000] [graphdriver] using prior storage driver "aufs"
INFO[0000] Graph migration to content-addressability took 0.00 seconds
INFO[0000] Firewalld running: false
INFO[0000] Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP address
WARN[0000] Your kernel does not support swap memory limit.
INFO[0000] Loading containers: start.
................................
INFO[0000] Loading containers: done. 
INFO[0000] Daemon has completed initialization 
INFO[0000] Docker daemon commit=c3959b1 execdriver=native-0.2 graphdriver=aufs version=1.10.2
INFO[0000] API listen on /var/run/docker.sock
```

-   **dm.basesize** -- Este parâmetro define o tamanho máximo do *container*. O chato disso é que você precisa deletar tudo dentro de "/var/lib/docker" (o que implica em matar todos os *containers* e imagens) e *restartar* o serviço do Docker.


```bash
root@linuxtips:~# dockerd --storage-opt dm.basesize=10G
INFO[0000] [graphdriver] using prior storage driver "aufs"
INFO[0000] Graph migration to content-addressability took 0.00 seconds
INFO[0000] Firewalld running: false
INFO[0000] Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can be used to set a preferred IP address
WARN[0000] Your kernel does not support swap memory limit.
INFO[0000] Loading containers: start.
..........................
INFO[0000] Loading containers: done.
INFO[0000] Daemon has completed initialization
INFO[0000] Docker daemon commit=c3959b1 execdriver=native-0.2 graphdriver=aufs version=1.10.2
INFO[0000] API listen on /var/run/docker.sock
```

-   **dm.fs** -- Especifica o *filesystem* do *container*. As opções suportadas são: **EXT4** e **XFS**.

## Opções de rede

Também é possível controlar como o *daemon* se comportará em relação à
rede:

-   **\--default-gateway** -- Autoexplicativo, né? Todos os *containers* receberão esse IP como *gateway*.

-   **\--dns** -- Também sem segredo: é o DNS que será usado para consultas.

-   **\--dns-search** -- Especifica o domínio a ser procurado, assim você consegue pesquisar máquinas sem usar o fqdn.

-   **\--ip-forward** -- Esta opção habilita o roteamento entre *containers.* Por padrão, ela já vem *setada* como *true*.

## Opções diversas

-   **\--default-ulimit** -- Passando isso para o *daemon*, todos os *containers* serão iniciados com esse valor para o "ulimit". Esta opção é sobrescrita pelo parâmetro "\--ulimit" do comando "docker container run", que geralmente vai dar uma visão mais específica.

-   **\--icc** -- "icc" vem de *inter container comunication*. Por padrão, ele vem marcado como *true*; caso você não queira esse tipo de comunicação, você pode marcar no *daemon* como *false*.

-   **\--log-level** -- É possível alterar também a forma como o Docker trabalha com *log*; em algumas situações (geralmente *troubleshoot*) você pode precisar de um *log* mais "verboso", por exemplo.



# Docker Machine

Nota: o Docker Machine e uma ferramenta legada/descontinuada. Em ambientes modernos, prefira Docker Desktop, provisionamento via cloud + Docker Engine, ou ferramentas como Terraform/Ansible.

## Ouvi dizer que minha vida ficaria melhor com o Docker Machine!

Certamente!

Com o Docker Machine você consegue, com apenas um comando, iniciar o seu
projeto com Docker!

Antes do Docker Machine, caso quiséssemos montar um Docker Host, era
necessário fazer a instalação do sistema operacional, instalar e
configurar o Docker e outras ferramentas que se fazem necessárias.

Perderíamos um tempo valoroso com esses passos, sendo que já poderíamos
trabalhar efetivamente com o Docker e seus *containers*.

Porém, tudo mudou com o Docker Machine! Com ele você consegue criar o
seu Docker Host com apenas um comando. O Docker Machine consegue
trabalhar com os principais *hypervisors* de VMs, como o VMware, Hyper-V
e Oracle VirtualBox, e também com os principais provedores de
infraestrutura, como AWS, Google Compute Engine, DigitalOcean,
Rackspace, Azure, etc.

Para que você possa ter acesso a todos os *drivers* que o Docker Machine
suporta, acesse:
[https://docs.docker.com/machine/drivers/](https://docs.docker.com/machine/drivers/).

Quando você utiliza o Docker Machine para instalar um Docker Host na
AWS, por exemplo, ele disponibilizará uma máquina com Linux e com o
Docker e suas dependências já instaladas.

### Vamos instalar?

A instalação do Docker Machine é bastante simples, por isso, vamos parar
de conversa e brincar! Vale lembrar que é possível instalar o Docker
Machine no Linux, MacOS ou Windows.

Para fazer a instalação do Docker Machine no Linux, faça:

```bash
# curl -L https://github.com/docker/machine/releases/download/v0.12.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine
# chmod +x /tmp/docker-machine
# sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
```

Para seguir com a instalação no MacOS:

```bash
$ curl -L https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine
$ chmod +x /usr/local/bin/docker-machine
```

Para seguir com a instalação no Windows caso esteja usando o Git *bash*:

```bash
$ if [[ ! -d "$HOME/bin" ]]; then mkdir -p "$HOME/bin"; fi
$ curl -L https://github.com/docker/machine/releases/download/v0.15.0/docker-machine-Windows-x86_64.exe > "$HOME/bin/docker-machine.exe"
$ chmod +x "$HOME/bin/docker-machine.exe"
```

Para verificar se ele foi instalado e qual a sua versão, faça:

```bash
root@linuxtips:~# docker-machine version
docker-machine version 0.15.0, build b48dc28

root@linuxtips:~#
```

Pronto. Como tudo que é feito pelo Docker, é simples de instalar e fácil
de operar. :)

### Vamos iniciar nosso primeiro projeto?

Agora que já temos o Docker Machine instalado em nossa máquina, já
conseguiremos fazer a instalação do Docker Host de forma bastante
simples -- lembrando que, mesmo que tivéssemos feito a instalação do
Docker Machine no Windows, conseguiríamos tranquilamente comandar a
instalação do Docker Hosts na AWS em máquinas Linux. Tenha em mente que
a máquina na qual você instalou o Docker Machine é o maestro que
determina a criação de novos Docker Hosts, seja em VMs ou em alguma
nuvem como a AWS.

Em nosso primeiro projeto, vamos fazer com que o Docker Machine instale
o Docker Host utilizando o VirtualBox.

Como utilizaremos o VirtualBox, é evidente que precisamos ter instalado
o VirtualBox em nossa máquina para que tudo funcione. ;)

Portanto:

```bash
root@linuxtips:~# apt-get install virtualbox
```

Para fazer a instalação de um novo Docker Host, utilizamos o comando
"docker-machine create". Para escolher onde criaremos o Docker Host,
utilizamos o parâmetro "\--driver", conforme segue:

```bash
root@linuxtips:~# docker-machine create --driver virtualbox linuxtips
Running pre-create checks...
(linuxtips) Default Boot2Docker ISO is out-of-date, downloading the latest release...
(linuxtips) Latest release for github.com/boot2docker/boot2docker is v17.05.0-ce
(linuxtips) Downloading /Users/linuxtips/.docker/machine/cache/boot2docker.iso from https://github.com/boot2docker/boot2docker/releases/download/v17.05.0-ce/boot2docker.iso...
(linuxtips) 0%....10%....20%....30%....40%....50%....60%....70%....80%....90%....100%
Creating machine...
(linuxtips) Copying /Users/linuxtips/.docker/machine/cache/boot2docker.iso to /Users/linuxtips/.docker/machine/machines/linuxtips/boot2docker.iso...
(linuxtips) Creating VirtualBox VM...
(linuxtips) Creating SSH key...
(linuxtips) Starting the VM...
(linuxtips) Check network to re-create if needed...
(linuxtips) Waiting for an IP...
Waiting for machine to be running, this may take a few minutes...
Detecting operating system of created instance...
Waiting for SSH to be available...
Detecting the provisioner...
Provisioning with boot2docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!

To see how to connect your Docker Client to the Docker Engine running on
this virtual machine, run: docker-machine env linuxtips

root@linuxtips:~#
```

Onde:

-   **docker-machine create** -- Cria um novo Docker Host.

-   **\--driver virtualbox** -- Irá criá-lo utilizando o VirtualBox.

-   **linuxtips** -- Nome da VM que será criada.

Para visualizar o *host* que acabou de criar, basta digitar o seguinte
comando:

```bash
root@linuxtips:~# docker-machine ls
NAME           ACTIVE  DRIVER     STATE   URL                         SWARM   DOCKER    ERRORS
linuxtips      -       virtualbox Running tcp://192.168.99.100:2376           v18.06.0  -
```

Como podemos notar, o nosso *host* está sendo executado perfeitamente!
Repare que temos uma coluna chamada URL, correto? Nela temos a URL para
que possamos nos comunicar com o nosso novo *host*.

Outra forma de visualizar informações sobre o *host*, mais
especificamente sobre as variáveis de ambiente dele, é digitar:

```bash
root@linuxtips:~# docker-machine env linuxtips
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/linuxtips/.docker/machine/machines/linuxtips"
export DOCKER_MACHINE_NAME="linuxtips"
# Run this command to configure your shell:
# eval "$(docker-machine env linuxtips)"

root@linuxtips:~#
```

Serão mostradas todas as variáveis de ambiente do *host*, como URL,
certificado e nome.

Para que você possa acessar o ambiente desse *host* que acabamos de
criar, faça:

```bash
root@linuxtips:~# eval "$(docker-machine env linuxtips)"
```

O comando "eval" serve para definir variáveis de ambiente através da
saída de um comando, ou seja, as variáveis que visualizamos na saída do
"docker-machine env linuxtips".

Agora que já estamos no ambiente do *host* que criamos, vamos visualizar
os *containers* em execução:

```bash
root@linuxtips:~# docker container ls
```

Claro que ainda não temos nenhum *container* em execução; vamos iniciar
o nosso primeiro agora:

```bash
root@linuxtips:~# docker container run busybox echo "LINUXTIPS, VAIIII"
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
385e281300cc: Pull complete
a3ed95caeb02: Pull complete
Digest: sha256:4a887a2326ec9e0fa90cce7b4764b0e627b5d6afcb81a3f73c85dc29cea00048
Status: Downloaded newer image for busybox:latest
LINUXTIPS, VAIIII

root@linuxtips:~#
```

Como podemos observar, o *container* foi executado e imprimiu a mensagem
"**LINUXTIPS, VAIIII**", conforme solicitamos.

Lembre-se de que o *container* foi executado em nosso Docker Host, que
criamos através do Docker Machine.

Para verificar o IP do *host* que criamos, faça:

```bash
root@linuxtips:~# docker-machine ip linuxtips
192.168.99.100

root@linuxtips:~#
```

Para que possamos acessar o nosso *host*, utilizamos o parâmetro "ssh"
passando o nome do *host* que queremos acessar:

```bash
root@linuxtips:~# docker-machine ssh linuxtips
```

Para saber mais detalhes sobre o *host*, podemos utilizar o parâmetro
"inspect":

```bash
root@linuxtips:~# docker-machine inspect linuxtips
{
    "ConfigVersion": 3,
    "Driver": {
        "IPAddress": "192.168.99.100",
        "MachineName": "linuxtips",
        "SSHUser": "docker",
        "SSHPort": 57249,
        "SSHKeyPath": "/Users/jeferson/.docker/machine/machines/linuxtips/id_rsa",
        "StorePath": "/Users/jeferson/.docker/machine",
        "SwarmMaster": false,
        "SwarmHost": "tcp://0.0.0.0:3376",
        "SwarmDiscovery": "",
        "VBoxManager": {},
        "HostInterfaces": {},
        "CPU": 1,
        "Memory": 1024,
        "DiskSize": 20000,
        "NatNicType": "82540EM",
        "Boot2DockerURL": "",
        "Boot2DockerImportVM": "",
        "HostDNSResolver": false,
        "HostOnlyCIDR": "192.168.99.1/24",
        "HostOnlyNicType": "82540EM",
        "HostOnlyPromiscMode": "deny",
        "UIType": "headless",
        "HostOnlyNoDHCP": false,
        "NoShare": false,
        "DNSProxy": true,
        "NoVTXCheck": false,
        "ShareFolder": ""
    },
    "DriverName": "virtualbox",
    "HostOptions": {
        "Driver": "",
        "Memory": 0,
        "Disk": 0,
        "EngineOptions": {
            "ArbitraryFlags": [],
            "Dns": null,
            "GraphDir": "",
            "Env": [],
            "Ipv6": false,
            "InsecureRegistry": [],
            "Labels": [],
            "LogLevel": "",
            "StorageDriver": "",
            "SelinuxEnabled": false,
            "TlsVerify": true,
            "RegistryMirror": [],
            "InstallURL": "https://get.docker.com"
        },
        "SwarmOptions": {
            "IsSwarm": false,
            "Address": "",
            "Discovery": "",
            "Agent": false,
            "Master": false,
            "Host": "tcp://0.0.0.0:3376",
            "Image": "swarm:latest",
            "Strategy": "spread",
            "Heartbeat": 0,
            "Overcommit": 0,
            "ArbitraryFlags": [],
            "ArbitraryJoinFlags": [],
            "Env": null,
            "IsExperimental": false
        },
        "AuthOptions": {
            "CertDir": "/Users/jeferson/.docker/machine/certs",
            "CaCertPath": "/Users/jeferson/.docker/machine/certs/ca.pem",
            "CaPrivateKeyPath": "/Users/jeferson/.docker/machine/certs/ca-key.pem",
            "CaCertRemotePath": "",
            "ServerCertPath": "/Users/jeferson/.docker/machine/machines/linuxtips/server.pem",
            "ServerKeyPath": "/Users/jeferson/.docker/machine/machines/linuxtips/server-key.pem",
            "ClientKeyPath": "/Users/jeferson/.docker/machine/certs/key.pem",
            "ServerCertRemotePath": "",
            "ServerKeyRemotePath": "",
            "ClientCertPath": "/Users/jeferson/.docker/machine/certs/cert.pem",
            "ServerCertSANs": [],
            "StorePath": "/Users/jeferson/.docker/machine/machines/linuxtips"
        }
    },
    "Name": "linuxtips"
}
```

Para parar o *host* que criamos:

```bash
root@linuxtips:~# docker-machine stop linuxtips
```

Para que você consiga visualizar o status do seu *host* Docker, digite:

```bash
root@linuxtips:~# docker-machine ls
```

Para iniciá-lo novamente:

```bash
root@linuxtips:~# docker-machine start linuxtips
```

Para removê-lo definitivamente:

```bash
root@linuxtips:~# docker-machine rm linuxtips
Successfully removed linuxtips
```