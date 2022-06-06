# Cadastro de Semenetes (seeds_system)

Trata-se de um app mobile escrito em Flutter que permite comunicação com um serviço BackEnd para
sincronização dos dados, assim como a persistência dos dados em um banco de dados local, permitindo manipulações
locais desses dados.

O aplicativo possui um modelo de autenticação baseado na conferência de um email válido previamente cadastrado junto ao nome do usuário.

É permitido que o usuário faça o cadastro de sementes, através do floating button e do menu drawer, com informações as seguintes informações: nome, fabricante, data de fabricação e validade. Em sua tela principal ele também pode fazer a pesquisa pelo nome das sementes.

O usuário poderá realizar logout e acessar uma nova conta sem que suas sementes cadastradas localmente sejam perdidas. A sincronização de dados está disponível com indicação no layout. Após sincronizados, os dados não podem mais ser alterados localmente.
