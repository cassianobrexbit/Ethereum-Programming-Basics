# Compilação e deploy na testnet

Neste capítulo vamos tratar da compilação do contrato e a publicação na tesnet para ser acessado e aberto à interação. As etapas de compilação são um pouco complexas a princípio e serão abordadas futuramente em um tutorial mais completo. A princípio utilizaremos o Remix, um compilador online de contratos. Para acessar o Remix, acesse este [link.](http://remix.ethereum.org/#optimize=false&version=soljson-v0.4.23+commit.124ca40d.js)

**Observação importante**: O remix pode ser acessado via HTTP e HTTPS. Eu não sei exatamente \(ainda\) o porquê, mas ocorre um erro quando conecto o remix no meu endpoint \(nó sincronizado com a blockchain através do **geth**, explicado no [primeiro capítulo](//chapter1.md)\) utilizando conexão HTTPS. Por isso aconselho sempre utilizar a conexão via HTTP.

![](/assets/remix1.png)

Para testar, Basta copiar o contrado do diretório **source **e clicar em **Start to compile** ou marcar a opção **Auto compile**, que compila automaticamente o contrato assim que ele é editado.

Em seguida, para conectar o compilador à rede e publicar o contrato na tesnet, acesse a aba **Run**. Selecione a opção **Web3 Provider**. Ele será redirecionado para o nó \(endpoint\) sincronizado com a rede no seu computador.

![](/assets/remix2.png)

Em seguida clique **OK **e confirme a URL do seu endpoint \(é padrão, não são necessárias alterações nessa parte\).

![](/assets/remix4b.png)

Confirme a URL do seu endpoint:

![](/assets/remix3.png)

Se a conexão do compilador com o seu endpoint ocorrer sem problemas, o ambiente selecionado deverá apontar para  a testnet Rinkeby. Automaticamente ele exibirá o endereço que você criou anteriormente e o saldo em Ethereum.

Observação: é necessário que a conta esteja desbloqueada.

![](/assets/remix5.png)

Por fim, para realizar o deploy do contrato na rede testnet, clique em **Create** e aguarde alguns segundos até o contrato ser publicado na blockchain. Você pode acompanhar o log da operação no espaço abaixo da área onde o contrato é digitado.

![](/assets/remix5.png)

Repare que foram criados dois botões. Esses botões interagem com os métodos que foram criados no contrato \(os nomes são os mesmos\). Para interagir com o contrato, informe um número no campo ao lado do botão **set **e clique para inserir. Em seguida, repare no log apresentando a transação submetida à rede.

![](/assets/remix6.png)

Após a transação ser publicada, clique no botão azul **get **para obter o valor inserido.

![](/assets/remix7.png)

Para verificar as informações da criação do contrato e inserção de valores no buscador de blocos da Etherscan, basta clicar nos links gerados no log.

Por enquanto isso é tudo pessoal. Em breve completarei esse tutorial com exemplos de operações CRUD em contratos e criação de structs e arrays. Também falarei da interação entre contratos.

[Index](/SUMMARY.md)                                                                                               [Capítulo 2](//chapter2.md)                                                                                  [Capítulo 4](//chapter4.md)

