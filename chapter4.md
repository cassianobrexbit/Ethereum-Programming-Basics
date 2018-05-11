# Trabalhando com structs e arrays

Neste capítulo farei uma breve abordagem sobre a utilização de structs e arrays utilizando o Solidity. Para quem já está um pouco familiarizado com Java, C, C++, Javascript ou C\#, provavelmente irá notar alguma semelhança na sintaxe. De certa forma isso facilitou o meu aprendizado.

Neste exemplo vamos tratar de uma registro de saída de equipamentos, onde cada registro possui um conjunto de itens.

### Structs

A sintaxe de uma struct no Solidity é muito semelhante a utilizada na liguagem C, por exemplo. Uma struct nada mais é do que um tipo de variável personalizada criada pelo usuário. Observe o seguinte trecho de código extraído [deste contrato](/source/EquipmentRegister.sol):

```
//omitted

struct EquipmentStruct{

        bytes32 equipmentDescription;
        bytes16 equipmentUnit;
        uint equipmentQuantity;
}

//omitted
```

Nesta struct temos três atributos, sendo uma descrição, a unidade de medida e quantidade. Os tipos de váriáveis dentro da struct são **bytes32** e **bytes16** para strings e **uint** para com números inteiros. Esses valores são definidos por meio de métodos setters do contrato.

### Arrays

**Observação importante:** A forma como um contrato é programado influencia diretamente no custo das transações, por isso recomenda-se cautela ao utilizar arrays e loops no solidity. Em um próximo tutorial explicarei como interagir com um contrato utilizando o web3.js, onde os loops poderão ser programados.

### Mapeamentos \(mappings\)

Os mapeamentos são, em geral, tabelas de hash distribuídas e gravam em um espaço de uma variável **bytes16**, que contém um identificador único de 16 caracteres para cada registro. Abaixo segue um exemplo de mapeamento de structs.

```
struct RegisterStruct {

        bytes32 registerOwnerName;
        bytes16 registerOrigin;
        bytes16 registerDestination;
        uint registerNumber;
        uint equipmentsIndex;
        uint index;
        mapping(uint => EquipmentStruct) equipmentStructs;
}

mapping(bytes16 => RegisterStruct)  registerStructs;
bytes16[] public registerIndex;
```

Observe que não há um campo de identificador único na struct _RegisterStruct_. Isto seria redundante pois este identificador está armazenado em um array chamado _registerIndex_, onde cada identificador é vinculado a um índice no momento da inserção do registro na blockchain.

```
 function insertRegister(
        bytes16 registerUuid, 
        bytes32 registerOwnerName,
        bytes16 registerOrigin,
        bytes16 registerDestination, 
        uint    registerNumber) 
        public
        returns(uint index)
    {
        if(isRegister(registerUuid))
            throw; 
        registerStructs[registerUuid].registerOwnerName = registerOwnerName;
        registerStructs[registerUuid].registerOrigin = registerOrigin;
        registerStructs[registerUuid].registerDestination = registerDestination;
        registerStructs[registerUuid].registerNumber = registerNumber;
        registerStructs[registerUuid].index = registerIndex.push(registerUuid)-1;

        emit LogNewRegister(
            registerUuid, 
            registerStructs[registerUuid].index, 
            registerOwnerName,
            registerOrigin,
            registerDestination, 
            registerNumber
        );
        return registerIndex.length-1;
}
```

Repare que dentro da struct RegisterStruct há um mapping _equipmentStructs_ que contém uma lista com os índices dos equipamentos de um registro.

```
mapping(uint => EquipmentStruct) equipmentStructs;
```

O array de equipamentos é preenchido através do método descrito a seguir:

```
 function insertEquipment(bytes16 rUuid, bytes32 eDesc, uint eQuant, bytes16 eUnit) public{

        RegisterStruct storage rs = registerStructs[rUuid];

        rs.equipmentStructs[rs.equipmentsIndex].equipmentDescription = eDesc;
        rs.equipmentStructs[rs.equipmentsIndex].equipmentQuantity = eQuant;
        rs.equipmentStructs[rs.equipmentsIndex].equipmentUnit = eUnit;
        rs.equipmentsIndex++;

    }
```

Os parâmetros desse método são:

* identificador de um registro já previamente inserido na blockchain;
* descrição do equipamento;
* quantidade de equipamentos;
* unidade de medida do equipamento.

### Getters e setters no Solidity

As funções acima citadas basicamente são _setters_, métodos responsáveis por inserir informações em um contrato. O exemplo a seguir contém o método que retorna as informações de um _RegisterStruct_. O parâmetro necessário é o identificador único do registro inserido:

```
function getRegister(bytes16 registerUuid)
        public 
        constant
        returns(uint registerNumber, bytes32 registerOwnerName, bytes16 registerOrigin, bytes16 registerDestination, uint equipmentsIndex, uint index)
    {

        return(

            registerStructs[registerUuid].registerNumber,
            registerStructs[registerUuid].registerOwnerName,
            registerStructs[registerUuid].registerOrigin, 
            registerStructs[registerUuid].registerDestination,
            registerStructs[registerUuid].equipmentsIndex,  
            registerStructs[registerUuid].index
        );
}
```

Para obter as informações sobre o array de equipamentos de um registro, é necessário informar o identificador do registro e o índice do equipamento a ser buscado. Uma dica para obter toda a lista de equipamentos é implementar utilizando o web3.js um loop que varre todo o _equipmentsIndex_ utilizando como condição de parada o tamanho do array de equipamentos de um registro.

```
function getEquipments(bytes16 rUuid, uint eIndex) public constant returns(bytes32 eDesc, uint eQuant, bytes16 eUnit)
    {

        return(
            registerStructs[rUuid].equipmentStructs[eIndex].equipmentDescription,
            registerStructs[rUuid].equipmentStructs[eIndex].equipmentQuantity,
            registerStructs[rUuid].equipmentStructs[eIndex].equipmentUnit
        );
}
```

Para obter a quantidade de registros informados utilize:

```
function getRegisterCount() 
        public
        constant
        returns(uint count)
    {
        return registerIndex.length;
}
```

Caso você não tenha o identificador único de um registro, utilize o método a seguir para obter essa informação por meio do índice do registro informado.

```
function getRegisterAtIndex(uint index)
        public
        constant
        returns(bytes16  registerUuid)
    {
        return registerIndex[index];
}
```

**Observação importante:** Quando o tipo de variável para strings utilizado é _bytes16_** **ou qualquer outro do tipo bytes, o retorno será no formado hexadecimal. Para converter ao formato UTF8 utilize no web3.js a função _**web3.toUtf8\(hexString\)**_, onde _hexString_ é o valor retornado em hexadecimal.

Por enquanto é tudo pessoal, no próximo capítulo mostrarei como funciona a interação entre contatos e a utilização de array de contratos.

