# Giropops Senhas


# Setup
## Primeiro crie uma instancia do REDIS

```sh
docker run -d --name redis -p 6379:6379 redis
```
## Build e Run da app

```sh
docker build -t giropops-senhas:1.0 .
 
docker run -d --name giropops-senhas -p 5000:5000 --env REDIS_HOST=172.21.0.1 giropops-senhas:1.0
```

Para descobrir o ip de REDIS_HOST, execure `ifconfig` (ambiente linux) e pegue o IP de `inet`

```sh
❯ ifconfig
br-0ae29aa29b83: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.21.0.1  netmask 255.255.0.0  broadcast 172.21.255.255
        ether 4a:bb:d6:9a:7a:7f  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```