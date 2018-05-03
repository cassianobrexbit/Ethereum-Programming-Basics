# Desenvolvimento de contratos

Nesta primeira parte trataremos da interação inicial com a blockchain, criação de endereços e como obter Ethereum na testnet através de faucets.

### Interagindo com a blockchain

Após configurar o ambiente e sincronizar com a testnet, é necessário criar uma conta \(endereço\) na blockchain. Para isto execute os comandos:

```
//para criar um diretório
mkdir eth-teste

cd eth-teste

//iniciar o diretório com o framework truffle
truffle init
```

Em seguida utilize o seguinte comando para acessar o console do Truffle e criar uma nova conta:

```
truffle console

//criar nova conta
web3.personal.newAccount('minhasenhaforteounao')
```

Obs: Anote este endereço para ser utilizado nas próximas etapas.

Obs²:  Altere a senha \(se quiser, é testnet, não faz diferença\).

Para publicar contatos e interagir com a blockchain é necessário desbloquear a a conta, para isso execute:

```
web3.personal.unlockAccount('seu_endereco_criado', 'minhasenhaforteounao', 15000)
```

As contas \(obviamente\) são criadas com o saldo zerado. Para obter Ethereum via faucets [acesse este link](https://faucet.rinkeby.io/) e siga as instruções. Você vai precisar do endereço criado no passo anterior.

Para verificar o saldo do endereço:

```
web3.eth.getBalance('seu_endereco_criado')
```

Para saber mais sobre comandos para interação com a blockchain, [acesse este link](https://github.com/ethereum/wiki/wiki/JavaScript-API).

### Criando um contrato simples

No diretório **source **deste projeto você pode encontrar algumas amostras de contratos \(você pode acessar por [aqui](/source)\). Nesta primeira etapa vamos utilizar o contrato [SampleContract.sol](/source/SampleContract.sol).

```
pragma solidity ^0.4.18;

contract SampleContract {

    uint numero;
    
    function set(uint x) {
        numero = x;
    }
    
    function get() constant returns (uint) {
       return numero;
    }
}
```



