REPORT Z_DADOS.
*DATA <nome da variavel> TYPE <tipo da variavel> LENGTH <tamanho> VALUE <valor a ser impresso>
"Declaracao de variaveis
DATA nome      TYPE C LENGTH 40.
DATA idade      TYPE Integer.
 "Endereco de cobranca
DATA endereco TYPE C LENGTH 50.
DATA cidade     TYPE C LENGTH 20.
DATA estado     TYPE C LENGTH 2 VALUE 'SP'.
DATA cep      TYPE C LENGTH 9.

*Like - DATA <nome variavel nova> LIKE <nome da variavel de origem>
"Endereco de Entrega
DATA endereco2 like endereco.
DATA cidade2     like cidade.
DATA estado2     like estado VALUE 'SP'.
DATA cep2          like cep.

"Entrade de dados
nome = 'Paula da Silva'.
idade = 25.

"Endereco de cobranca
endereco = 'Rua XV de novembro, 85'.
cidade     = 'Santos'.
cep          = '65000-001'.

"Endereco de Entrega
endereco2 = 'Rua XV de novembro, 89'.
cidade2     = 'Santos'.
cep2          = '65000-002'.

"Saida de dados
Write : 'Nome: ' , nome.
Write : / 'Idade: ' , idade.
Write : / 'Endereço de Cobrança.....'.
Write : / 'Endereço: ' , endereco.
Write : / 'Cidade: ' , cidade.
Write : / 'Estado: ' , estado.
Write : / 'Endereço de Entrega.....'.
Write : / 'Endereço: ' , endereco2.
Write : / 'Cidade: ' , cidade2.
Write : / 'Estado: ' , estado2.