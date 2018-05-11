# Configurações iniciais

Este ambiente foi configurado utilizando o sistema operacional Linux Ubuntu 17.04. As configurações podem ser feitas também em ambiente Windows, mas dado as clássicas restrições de acesso que o Windows possui, é possível que ocorram contratempos nesse processo.

### Instalação do Geth no Ubuntu 17.04 via PPA

O **geth** é a implementação do Ethereum na linguagem **Go** e pode ser instalado de diferentes maneiras. Nesse tutorial será apresentado como instalar o **geth** utilizando o gerenciador de pacotes **apt** do Ubuntu.

Para instalar as dependências necessárias e adicionar o **geth** no repositório de pacotes do Ubuntu, execute os seguintes comandos:

```
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
```

Em seguida atualize o repositório e instale o **geth**:

```
sudo apt-get update
sudo apt-get install ethereum
```

Para sincronizar o seu nó com a blockchain do Ethereum \(nesse caso é a testnet Rinkeby\) execute o seguinte comando

```
geth --rinkeby --syncmode "fast" --rpc --rpcapi db,eth,net,web3,personal --cache=1024  --rpcport 8545 --rpcaddr 127.0.0.1 --rpccorsdomain "*"
```

Obs: O tempo de sincronização vai depender da sua capacidade de hardware e banda de internet. Na minha instalação eu utilizei uma máquina com um processador Core i7 de 7° geração e uma conexão de 50 mbps. O tempo foi de cerca de 45 minutos.

Obs²:Para verificar o número do último bloco da rede tesnet Rinkeby, acesse: [https://rinkeby.etherscan.io/](https://rinkeby.etherscan.io/).

### Instalação do NodeJS

Para instalar o NodeJS no Ubuntu é necessário configurar o repositório de pacotes com o seguinte comando:

```
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
```

Caso não tenha o **curl **instalado, execute:

```
sudo apt-get install curl -y
```

Em seguida instale o NodeJS :

```
sudo apt-get install -y nodejs
```

Para instalar o **npm **execute:

```
sudo npm install npm -g
```

Para verificar a versão do node e do npm:

```
npm -v
node -v
```

### Instalação do framework Truffle

Nesse tutorial utilizaremos o framework Truffle que permite a execução de comandos para interagir com a blockchain do Ethereum. Para isto execute o comando :

```
sudo npm install -g truffle
```

[Index](/SUMMARY.md)                                                                                                                                                                                                  [Capítulo 2](//chapter2.md)

