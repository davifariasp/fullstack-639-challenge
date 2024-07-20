<h1 align="center">
  <img alt="Logo 639" src="https://639app.com/_nuxt/img/logo.54e5dcc.svg" height="50px" />
</h1>


<p align="center">
  <a href="#page_with_curl-sobre">Sobre</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#hammer-tecnologias">Tecnologias</a>
  &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#sos-desafios">Desafios</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#rotating_light-próximos-passos">Próximos passos</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#sunrise-interface">Interface</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#books-requisitos">Requisitos</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#rocket-iniciando">Iniciando</a>
</p>

<div align="center">
    <img alt="Login" src="https://i.imgur.com/1iCqo2I.png" width="400" />
    <img alt="Não autorizado" src="https://i.imgur.com/0PcYude.png" width="400" />
</div>

<div align="center">
    <img alt="Home" src="https://i.imgur.com/dI4hcZL.png" width="400" />
    <img alt="Adicionar" src="https://i.imgur.com/AdoFBZB.png" width="400" />
</div>

<div align="center">
    <img alt="Home preenchida" src="https://i.imgur.com/ZHaqEwN.png" width="400" />
    <img alt="Editar" src="https://i.imgur.com/QTCY4gP.png" width="400" />
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
- Redis *
- Nginx
- Docker
- Flutter
- Dart

* Tecnologia que ainda pretendo implementar no projeto.

## :sos: Desafios

O prazo de entrega era 3 dias. Então o desafio foi realmente um desafio, pelos requisitos e pelo tempo limitadissimo de desenvolvimento. Mas em conversa com o PM/Recrutador, ele falou que implementar todas as features era um mero detalhe, e que o importante era eu saber o que deveria ser feito para serem implementadas, caso não conseguisse a tempo.

Primeira vez desenvolvendo em .NET, mas me surpreendi positivamente com a linguagem e com o framework. Por ter uma vasta experiência com desenvolvimento de API, acaba que de um framework para outro, muda apenas alguns detalhes, mas a essência para o desenvolvimento acaba permanecendo a mesma. Desenvolver em .NET se assemelha bastante al desenvolvimento em NodeJS, e isso é positivo para mim, pois sempre gostei da forma simplificada do desenvolvimento de api nesse framework.

Agora na parte do desenvolvimento mobile, o desafio foi na questão de configuração do Firebase (sempre é algo trabalhoso e cheio de detalhes), como também na configuração para uso da geolocalização.

No mais, o desafio ficou por parte do tempo. Infelizmente não consegui implementar todas as features, mas consegui explicar bem como seria o desenvolimento.

## :rotating_light: Próximo passos

### Ajustar mensageria
Uma das features a ser implementada era a seguinte:
Ao ser registrado um alerta climático em determinada região, deve-se enviar notificação para todos os usuários que estejam ali. A proposta que eu dei para isso foi, o usuário ao logar no sistema, enviava sua localização atual para o Redis que iria armazenar as coordenadas. E ai entrava o **cron job** (agendador de tarefas), que ficaria rodando um serviço para verificar no banco de dados se haveria algum alerta climatico e se sim, verificasse no redis os dispositivos que estavam conectados nessa região e enviasse uma notificação.

### Login social

Dei baixa prioridade a essa feature pois ela não era tão relavente assim pro sistema, e que requer um certo trabalho. Então seria algo a ser implementado, levando em cosideração que tem de haver uma logica relacional entre os dados do login social (via Firebase) e a tabela usuários no PostgreSQL.

## :sunrise: MobX

Priorizei fazer a mudança de estados via setState(), para otimizar o trabalho. Mas seria bom implementar o MobX a título de estudo. 

## :books: Requisitos

As tecnologias a seguir são necessárias para conseguir rodar o projeto em sua máquina.

- Ter [**Git**](https://git-scm.com/) para clonar o projeto.
- Criar um projeto no [**Firebase**](https://firebase.google.com/) para usar so Cloud messaging.
- Ter [**Docker**](https://www.docker.com/get-started/) para executar o projeto.

## :rocket: Iniciando
``` bash
  # Clonar o projeto:
  $ git clone git@github.com:davifariasp/insight-fullstack-challenge.git

  # Entrar no diretório:
  $ cd insight-fullstack-challenge

  # Entrar da spa:
  $ cd spa

  #Adicionar variável de ambiente
  $ nano .env

  #Vai colar:

  NEXT_PUBLIC_URL_API = http://localhost:api
  
  #Vai salvar
  [CTRL + O] de depois [ENTER]

  #Depois fechar editor
  [CTRL + X]

  # Compor o projeto:
  $ docker compose up -d

  # Acesso o front:
  $ http://localhost

  # Acesso ao back-end:
  $ http://localhost/api
```