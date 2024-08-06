<h1 align="center">
  <img alt="Logo 639" src="https://639app.com/_nuxt/img/logo.54e5dcc.svg" height="50px" />
</h1>


<p align="center">
  <a href="#page_with_curl-sobre">Sobre</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#hammer-tecnologias">Tecnologias</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#sos-desafios">Desafios</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#rotating_light-próximos-passos">Próximos passos</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#golf-rotas">Rotas</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#books-requisitos">Requisitos</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#rocket-iniciando">Iniciando</a>
</p>

<div align="center">
    <img alt="Tela de login" src="https://i.imgur.com/UOdLaqp.png" width="200" />
     <img alt="Tela de registro" src="https://i.imgur.com/8tbrKrX.png" width="200" />
     <img alt="Logando" src="https://i.imgur.com/l6B98X7.png" width="200" />
</div>

<div align="center">
    <img alt="Logado" src="https://i.imgur.com/m0WdoED.png" width="200" />
    <img alt="Uma notificação" src="https://i.imgur.com/ByIOg6Z.png" width="200" />
    <img alt="Várias notificações" src="https://i.imgur.com/udFfS2t.png" width="200" />
</div>

## :page_with_curl: Sobre

Este repositório é referente ao **Desafio Fullstack 639**. 

O presente desafio consiste na criação de um projeto Fullstack, utilizando .NET Framework 8.0 no back-end e o Framework Flutter para a criação de uma aplicação mobile.

Os requisitos do desafio foram os seguintes:

Back-end
- Desenvolver uma API para um sistema de tracking do clima tempo
- Swagger
- Middleware de autênticação das rotas
- 1 Cron job
- Serviço de mensageria
- Endpoint para cadastro
- Endpoint para login
- Endpoint para pegar dados climaticos
- Endpoint para simular mudança climática

Front-end
- Arquitetura MVVM
- Usar geolocalização
- Receber notificações
- Tela de login e cadastro
- Tela para mostrar dados climáticos
- Login social (Google/Facebook)
- Utilizar Modular para roteamento e injeção de dependencia
- Usar MobX para gerenciamento de estado.


## :hammer: Tecnologias

- Framework 8.0
- C#
- Firebase
- PostgreSQL
- Redis
- Nginx
- Docker
- Flutter
- Dart


## :sos: Desafios

O prazo de entrega era 3 dias. Então o desafio foi realmente um desafio, pelos requisitos e pelo tempo limitadissimo de desenvolvimento. Mas em conversa com o PM/Recrutador, ele falou que implementar todas as features era um mero detalhe, e que o importante era eu saber o que deveria ser feito para serem implementadas, caso não conseguisse a tempo.

Primeira vez desenvolvendo em .NET, mas me surpreendi positivamente com a linguagem e com o framework. Por ter uma vasta experiência com desenvolvimento de API, acaba que de um framework para outro, muda apenas alguns detalhes, mas a essência para o desenvolvimento acaba permanecendo a mesma. Desenvolver em .NET se assemelha bastante al desenvolvimento em NodeJS, e isso é positivo para mim, pois sempre gostei da forma simplificada do desenvolvimento de api nesse framework.

Agora na parte do desenvolvimento mobile, o desafio foi na questão de configuração do Firebase (sempre é algo trabalhoso e cheio de detalhes), como também na configuração para uso da geolocalização.

No mais, o desafio ficou por parte do tempo. Infelizmente não consegui implementar todas as features, mas consegui explicar bem como seria o desenvolimento.

## :rotating_light: Próximos passos

### Login social

Dei baixa prioridade a essa feature pois ela não era tão relavente assim pro sistema, e que requer um certo trabalho. Então seria algo a ser implementado, levando em cosideração que tem de haver uma logica relacional entre os dados do login social (via Firebase) e a tabela usuários no PostgreSQL.

### MobX

Priorizei fazer a mudança de estados via setState(), para otimizar o trabalho. Mas seria bom implementar o MobX a título de estudo. 

## :books: Requisitos

As tecnologias a seguir são necessárias para conseguir rodar o projeto em sua máquina.

- Ter [**Git**](https://git-scm.com/) para clonar o projeto.
- Ter acesso a [**Weather API**](https://www.weatherapi.com/) para pegar os dados climáticos.
- Criar um projeto no [**Firebase**](https://firebase.google.com/) para usar so Cloud messaging. Baixe o arquivo firebase.json e cole tanto na pasta "app" quanto na pasta "backend/api".
- Ter [**Docker**](https://www.docker.com/get-started/) para executar o projeto.

## :golf: Rotas
A API oferece Swagger para documentação das rotas, mas aqui vão as principais:

### Criar alerta climático
`POST - /weather/alert`
Exemplo de alerta:

```bash
{
  "title": "string",
  "lat": 0,
  "lon": 0,
  "running": true
}
```

### Pegar tempo de determinada localização
`POST - /weather/{lat}&{lon}`

### Criar notificação
`POST - /weather/notification`

Exemplo de alerta:

```bash
{
  "tokenDevice": "string",
  "title": "string",
  "body": "string"
}
```

## :rocket: Iniciando
``` bash
  # Clonar o projeto:
  $ git clone git@github.com:davifariasp/insight-fullstack-challenge.git

  # Entrar no diretório:
  $ cd fullstack-639-challenge

  # Entrar da spa:
  $ cd backend/api

  #Adicionar variável de ambiente
  $ nano .env

  #Vai colar:

  API_KEY = {CHAVE DE AUTENTICACAO DA WEATHER API}
  
  #Vai salvar
  [CTRL + O] de depois [ENTER]

  #Depois fechar editor
  [CTRL + X]

  # Compor o projeto:
  $ docker compose up -d
```

Agora o backend esta pronto para ser consumido pelo aplicativo. Vá até a pasta app e rode no simulador Android(!!!). O simulador iOS não permite notificações para usuários que não tem a conta de desenvolvedor.