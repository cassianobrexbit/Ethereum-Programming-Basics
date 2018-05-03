# Desenvolvimento de contratos

Nesta primeira parte trataremos da interação inicial com a blockchain, criação de endereços e como obter Ethereum na testnet através de faucets.

### Interagindo com a blockchain

Após configurar o ambiente e sincronizar com a testnet, é necessário criar uma conta \(endereço\) na blockchain. Para isto execute os comandos:

```
//para criar um diretório
mkdir eth-teste

//iniciar o diretório com o framework truffle
truffle init
```

Em seguida utilize o seguinte comando para acessar o console do Truffle e criar uma nova conta:

```
truffle console

//criar nova conta
web3.personal.newAccount('minhasenhaforteounao')
```



