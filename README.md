# Mocky Mouse

O Mocky Mouse ajuda você a construir APIs rests simuladas sem nenhuma codificação. Esta ferramenta irá ajudá-lo a realizar a depuração, interceptação e proxy de requisições HTTP.

## Tech Stack

| Tecnologia    | Versão  |
| ------------- | ------- |
| Ruby          | 3.3.1   |
| Rails         | 6.1     |
| PostgreSQL    | 14.7    |

## Ambiente de desenvolvimento

### Dependências

Para criar e rodar o ambiente de desenvolvimento são necessárias as seguintes ferramentas:

- [Git](https://git-scm.com/doc)
- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Como executar o projeto

1. Rodar
```console
docker-compose up --build -d
docker-compose exec backend bundle install
docker-compose exec backend bundle exec rails db:create db:migrate db:seed
```
3. Acesse o ambiente local usando a url http://localhost:3002/
