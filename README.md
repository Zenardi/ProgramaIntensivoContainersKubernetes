# PICK - Programa Intensivo de Containers e Kubernetes
Conteudo do Programa Intensivo de Container e Kubernetes ministrado por [@badtuxx](https://github.com/badtuxx) e pela [linux TIPS](https://linuxtips.io)


---

## Descomplicando Containers

<details>
<summary class="summary">DAY-01</summary>

- [Descomplicando Containers - DAY-01](DescomplicandoContainers/day-01/README.md#descomplicando-containers---day-01)
- [O que é container?](DescomplicandoContainers/day-01/README.md#o-que-é-container)
  - [Então vamos lá, o que é um container?](DescomplicandoContainers/day-01/README.md#então-vamos-lá-o-que-é-um-container)
  - [E quando começou que eu não vi?](DescomplicandoContainers/day-01/README.md#e-quando-começou-que-eu-não-vi)
- [O que é o Docker?](DescomplicandoContainers/day-01/README.md#o-que-é-o-docker)
  - [Onde entra o Docker nessa história?](DescomplicandoContainers/day-01/README.md#onde-entra-o-docker-nessa-história)
  - [E esse negócio de camadas?](DescomplicandoContainers/day-01/README.md#e-esse-negócio-de-camadas)
    - [Copy-On-Write (COW) e Docker](DescomplicandoContainers/day-01/README.md#copy-on-write-cow-e-docker)
  - [Storage drivers](DescomplicandoContainers/day-01/README.md#storage-drivers)
    - [AUFS (Another Union File System)](DescomplicandoContainers/day-01/README.md#aufs-another-union-file-system)
    - [Device Mapper](DescomplicandoContainers/day-01/README.md#device-mapper)
    - [OverlayFS e OverlayFS2](DescomplicandoContainers/day-01/README.md#overlayfs-e-overlayfs2)
    - [BTRFS](DescomplicandoContainers/day-01/README.md#btrfs)
  - [Docker Internals](DescomplicandoContainers/day-01/README.md#docker-internals)
  - [Namespaces](DescomplicandoContainers/day-01/README.md#namespaces)
    - [PID namespace](DescomplicandoContainers/day-01/README.md#pid-namespace)
    - [Net namespace](DescomplicandoContainers/day-01/README.md#net-namespace)
    - [Mnt namespace](DescomplicandoContainers/day-01/README.md#mnt-namespace)
    - [IPC namespace](DescomplicandoContainers/day-01/README.md#ipc-namespace)
    - [UTS namespace](DescomplicandoContainers/day-01/README.md#uts-namespace)
    - [User namespace](DescomplicandoContainers/day-01/README.md#user-namespace)
  - [Cgroups](DescomplicandoContainers/day-01/README.md#cgroups)
  - [Netfilter](DescomplicandoContainers/day-01/README.md#netfilter)
  - [Para quem ele é bom?](DescomplicandoContainers/day-01/README.md#para-quem-ele-é-bom)
- [Instalando o Docker](DescomplicandoContainers/day-01/README.md#instalando-o-docker)
  - [Quero instalar, vamos lá?](DescomplicandoContainers/day-01/README.md#quero-instalar-vamos-lá)
  - [Instalando no Debian/Centos/Ubuntu/Suse/Fedora](DescomplicandoContainers/day-01/README.md#instalando-no-debiancentosubuntususefedora)
  - [Instalando 'manualmente' no Debian](DescomplicandoContainers/day-01/README.md#instalando-manualmente-no-debian)
    - [Dica importante](DescomplicandoContainers/day-01/README.md#dica-importante)
- [Criando e administrando containers Docker](DescomplicandoContainers/day-01/README.md#criando-e-administrando-containers-docker)
  - [Então vamos brincar com esse tal de container!](DescomplicandoContainers/day-01/README.md#então-vamos-brincar-com-esse-tal-de-container)
  - [Legal, quero mais!](DescomplicandoContainers/day-01/README.md#legal-quero-mais)
    - [Modo interativo](DescomplicandoContainers/day-01/README.md#modo-interativo)
    - [Daemonizando o container](DescomplicandoContainers/day-01/README.md#daemonizando-o-container)
  - [Entendi, agora vamos praticar um pouco?](DescomplicandoContainers/day-01/README.md#entendi-agora-vamos-praticar-um-pouco)
  - [Tá, agora quero sair...](DescomplicandoContainers/day-01/README.md#tá-agora-quero-sair)
  - [Posso voltar ao container?](DescomplicandoContainers/day-01/README.md#posso-voltar-ao-container)
  - [Continuando com a brincadeira...](DescomplicandoContainers/day-01/README.md#continuando-com-a-brincadeira)
  - [Subindo e matando containers...](DescomplicandoContainers/day-01/README.md#subindo-e-matando-containers)
  - [Visualizando o consumo de recursos pelo container...](DescomplicandoContainers/day-01/README.md#visualizando-o-consumo-de-recursos-pelo-container)
- [docker container logs \[CONTAINER ID\]](DescomplicandoContainers/day-01/README.md#docker-container-logs-container-id)
- [docker container logs -f \[CONTAINER ID\]](DescomplicandoContainers/day-01/README.md#docker-container-logs--f-container-id)
  - [Cansei de brincar de container, quero removê-lo!](DescomplicandoContainers/day-01/README.md#cansei-de-brincar-de-container-quero-removê-lo)


</details>


<details>
<summary class="summary">DAY-02</summary>

- [Descomplicando Containers - DAY-02](DescomplicandoContainers/day-02/README.md#descomplicando-containers---day-02)
- [Meu primeiro e tosco dockerfile...](DescomplicandoContainers/day-02/README.md#meu-primeiro-e-tosco-dockerfile)
- [Criando e gerenciando imagens](DescomplicandoContainers/day-02/README.md#criando-e-gerenciando-imagens)
  - [Agora eu quero criar minha imagem, posso?](DescomplicandoContainers/day-02/README.md#agora-eu-quero-criar-minha-imagem-posso)
  - [Vamos começar do começo então, dockerfile!](DescomplicandoContainers/day-02/README.md#vamos-começar-do-começo-então-dockerfile)
- [Multi-stage](DescomplicandoContainers/day-02/README.md#multi-stage)
- [Entendendo volumes](DescomplicandoContainers/day-02/README.md#entendendo-volumes)
  - [Introdução a volumes no Docker](DescomplicandoContainers/day-02/README.md#introdução-a-volumes-no-docker)
  - [Criando volumes](DescomplicandoContainers/day-02/README.md#criando-volumes)
  - [Localizando volumes](DescomplicandoContainers/day-02/README.md#localizando-volumes)
  - [Criando e montando um data-only container](DescomplicandoContainers/day-02/README.md#criando-e-montando-um-data-only-container)
  - [Sempre é bom um backup...](DescomplicandoContainers/day-02/README.md#sempre-é-bom-um-backup)
- [Compartilhando as imagens](DescomplicandoContainers/day-02/README.md#compartilhando-as-imagens)
  - [O que é o Docker Hub?](DescomplicandoContainers/day-02/README.md#o-que-é-o-docker-hub)
  - [Vamos criar uma conta?](DescomplicandoContainers/day-02/README.md#vamos-criar-uma-conta)
  - [Agora vamos compartilhar essas imagens na *interwebs*!](DescomplicandoContainers/day-02/README.md#agora-vamos-compartilhar-essas-imagens-na-interwebs)
  - [Não confio na internet; posso criar o meu *registry* local?](DescomplicandoContainers/day-02/README.md#não-confio-na-internet-posso-criar-o-meu-registry-local)

</details>


<details>
<summary class="summary">DAY-03</summary>

</details>


---