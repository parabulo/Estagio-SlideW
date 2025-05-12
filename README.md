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

Manter paginação mostrada de fazer pedido de 20 elementos por página, mantendo os 4 primeiros no carrossel e os outros 16 listados pelos cartões.

## Progressão
#### Dia 1:
Não muita familiaridade com Flutter, apesar de não ser completamente desconhecido(nunca tive um projeto em flutter realmente completo, e faz mais de 1 ano). Ajuste rápido com a estrutura padrão usada em Flutter observando alguns códigos feito em fóruns da internet procurando por elementos similares(header, footer, ETC) e na própria documentação, prevendo que o talvez o maior problema seja o uso do GET http com a API, priorizei a tentativa da implementação dessa chamada dos dados para a página de listagem dos filmes.