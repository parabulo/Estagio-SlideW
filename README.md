## Proposta
A proposta é a criação de uma página de catálogo de filmes, esse catalogo sendo fornecido pela empresa através da API.
Dentre os requesitos estão:
- Fazer a página em um Projeto **Flutter** ou **Next.JS**
- Possuir a mesma **estrutura geral** que a apresentada no protótipo
Considerando a estrutura apresentada não parece relacionar com um sistema de streaming, mas algo mais similar com um letterboxd por exemplo, ter isso em mente com estruturação do site e caso adicione mais ideias ao projeto.

### Estrutura
Header com logo e nome do serviço. Seguindo de um Carrosel mostrando alguns dos filmes mais avaliados, esse carrosel tendo um indicador de seus itens.

Sendo seguido pela listagem dos filmes que estão sendo posicionados em Cards, esses Cards possuindo um poster do filme em questão, o nome, ano de lançamento, diretor, ator principal, ator coadjuvante e um campo destacado com a nota do filme de 0 a 10. A opção de selecionar a página de filmes do catalogo para avançar ou regressar um outro lote.

E por fim um Footer com novamente o nome da empresa e sua logo. Acompanhado de outras redes da empresa(Facebook, Instagram, etc) e seus documentos legais, como termos de serviço e política de privacidade.

Manter paginação mostrada de fazer pedido de 20 elementos por página, mantendo os 4 primeiros no carrossel(pódium e menção honrosa) e os outros 16 listados pelos cartões.

## Progressão
#### Dia 1:
Não muita familiaridade com Flutter, apesar de não ser completamente desconhecido(nunca tive um projeto em flutter realmente completo, e faz mais de 1 ano). Ajuste rápido com a estrutura padrão usada em Flutter observando alguns códigos feito em fóruns da internet procurando por elementos similares(header, footer, ETC) e na própria documentação, prevendo que o talvez o maior problema seja o uso do **GET http** com a API, priorizei a tentativa da implementação dessa chamada dos dados para a página de listagem dos filmes.
#### Dia 2:
Criado uma página no projeto para listar os filmes. Foi estruturado os cards que serão usadas as informações obtidas pelas API's, trabalho até que simples quando se acostuma com o modo de encadeamento de containers do Flutter. O maior problema sendo o **Wrap** para listar os vários cards diferentes. Instanciados Header e Footer da página, e feito um processo de padronização em relação a proporção da página proposta.
#### Dia 3:
Tendo feito a listagem de todos os filme com os cards deve haver uma serparação de alguns filmes sendo mostrados como **destaque** em um hero carrossel, como os dados em sí foram organizados em uma lista deve haver um modo de fazer esse instanciamento de forma simples. O que pode até ser verdade no caso de fazer o chamado dos dados, no entanto a implementação do carrosel tem sido problemática, retornando a questão de ficar um minimo perdido em relação a estrutura dos códigos Flutter assim como o dia 1. Fiz alguma tentativas na visualização das logos que não queriam ser encontradas pelo projeto Flutter e, por fim passei a outro elemento que foram os botões da paginação para continuar mantendo o ritmo.
#### Dia 4:
Implementei os botões para funcionar de modo em que eles mostram as duas próximas páginas assim como as duas últimas páginas, não só isso mas também a implementação da troca de página mesmo, fazendo o chamado dos próximos 20 filmes para serem listados, o que foi fácil a implementação apenas fazendo a adição na URL da API fornecida. Depois de diferentes modos de lidar, as logos no Header e no Footer simplesmente decidiram se resolver sozinhas, foquei na paginação e em algum momento elas apenas decidiram existir na página.
#### Dia 5:
Os botões gerados para a transição das páginas não consideravam o final da lista de filmes, podendo avançar infinitamente pra as próximas páginas, agora foi colocado um limite relativo ao JSON fornecido. O **Carrossel** foi implementado, utilzando os primeiros 4 filmes da devida página os categorizando como "Destaques", com um timer de 7 segundos rolando os itens do Carrossel, também dando a opção dessa mudança de itens serem feitas de modo manual. Considerando que o carrossel foi um outro widget **stateful** esperava muito mais problemas em relação do estado do mesmo e como manusear isso, mas acabou sendo uma das partes mais tranquilas da página como um todo.