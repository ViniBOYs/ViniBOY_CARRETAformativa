create database formativaBOY;
use formativaBOY;
drop database formativaBOY;

create table ocupacoes(
	id bigint not null auto_increment,
    ocupacaoNome varchar(50) not null,
    descricao varchar(200),
    primary key(id)
);

create table acessRule(
	id bigint not null auto_increment,
    acessRuleName varchar(50) not null,
    acessRuleDescription varchar(200) not null,
    primary key(id)
);

create table user(
	id bigint auto_increment not null,
    nome varchar(150) not null,
    dataDeNascimento date not null,
    dataDeCadastro datetime not null default now(),
    senha varchar(50) not null,
    email varchar(100) not null,
    ocupacoesFK bigint not null,
    acessRulesFK bigint not null,
    primary key(id),
    foreign key(ocupacoesFK) references ocupacoes(id),
    foreign key(acessRulesFK) references acessRule(id)  
    
);

create table local(
	id bigint not null auto_increment,
    nomeLocal varchar(100) not null,
    lotMax int not null,
    bloco enum('A','B','C','D') not null,
	primary key(id)
);

create table equipamentos(
	id bigint not null auto_increment,
    nomeEquipamento varchar(100) not null,
    primary key(id)
);

create table checklistSala(
	id bigint not null auto_increment,
    nomeLocalFK bigint not null,
    equipamentosFK bigint not null,
    primary key(id),
    foreign key(nomeLocalFK) references local(id),
    foreign key(equipamentosFK) references equipamentos(id)
);

create table evento(
	id bigint not null auto_increment,
    nomeEvento varchar(150) not null,
    localFK bigint not null,
    totVagas int not null,
    vagasOcupadas int not null,
    vagas int not null,
    diaHoraInicioEv datetime not null,
    diaHoraFinalEv datetime not null,
    inicioCheckin datetime not null,
    finalCheckin datetime not null,
    primary key(id),
    foreign key(localFK) references local(id)
);

create table ticket(
	id bigint not null auto_increment,
    userFK bigint not null,
    eventoFK bigint not null,
    horarioEmissão datetime not null default now(),
    primary key(id),
    foreign key(userFK) references user(id),
    foreign	key(eventoFK) references evento(id)
);

# Imputs

insert into ocupacoes (ocupacaoNome, descricao) values
('Coordenador', 'Responsável pela coordenação geral'),
('Orientador', 'Responsável pela orientação dos alunos'),
('Assistente Social', 'Responsável pelo suporte social'),
('Secretária', 'Responsável pelas atividades administrativas');


insert into acessRule (acessRuleName, acessRuleDescription) values
('Admin', 'Acesso total à aplicação'),
('Gestor', 'Acesso ao cadastro de usuários, cancelamento de eventos, ambientes, entre outros.'),
('Usuário', 'Permite fazer reservas, mas não pode cadastrar nenhum usuário nem cancelar eventos'),
('Visitante', 'Permite a inscrição em um evento participante'),
('Desativado', 'Usuario desligado da aplicação');


insert into user (nome, dataDeNascimento,dataDeCadastro, senha, email, ocupacoesFK, acessRulesFK) values
('Usuário 1', '1990-01-20',now(), 'senha1', 'user1@vinimail.com', 1, 1),
('Usuário 2', '1991-02-20',now(), 'senha2', 'user2@vinimail.com', 2, 2),
('Usuário 3', '1992-03-20',now(), 'senha3', 'user3@vinimail.com', 3, 3),
('Usuário 4', '1993-04-20',now(), 'senha4', 'user4@vinimail.com', 4, 4),
('Usuário 5', '1994-05-20',now(), 'senha5', 'user5@vinimail.com', 1, 2),
('Usuário 6', '1995-06-20',now(), 'senha6', 'user6@vinimail.com', 2, 3),
('Usuário 7', '1996-07-20',now(), 'senha7', 'user7@vinimail.com', 3, 4),
('Usuário 8', '1997-08-20',now(), 'senha8', 'user8@vinimail.com', 4, 1),
('Usuário 9', '1998-09-20',now(), 'senha9', 'user9@vinimail.com', 1, 3),
('Usuário 10', '1999-10-20',now(), 'senha10', 'user10@vinimail.com', 2, 4),
('Usuário 11', '1980-01-05',now(), 'senha11', 'user11@vinimail.com', 3, 1),
('Usuário 12', '1981-02-05',now(), 'senha12', 'user12@vinimail.com', 4, 2),
('Usuário 13', '1982-03-05',now(), 'senha13', 'user13@vinimail.com', 1, 4),
('Usuário 14', '1983-04-05',now(), 'senha14', 'user14@vinimail.com', 2, 1),
('Usuário 15', '1984-05-05',now(), 'senha15', 'user15@vinimail.com', 3, 2);

insert into equipamentos (nomeEquipamento) values
('Projetor'),
('TV Smart'),
('Ar condicionado'),
('WorkStation'),
('Cadeira Gamer');

insert into local (nomeLocal, bloco, lotMax) values
('Laboratório de Eletrônica 1', 'A', 40),
('Sala de Reuniões 2', 'B', 15),
('Auditório Principal', 'C', 80),
('Sala de Estudos 3', 'D', 20);

insert into evento (nomeEvento, localFK, totVagas, vagasOcupadas, diaHoraInicioEv, diaHoraFinalEv, inicioCheckin, finalCheckin ) values
('Evento 1', 1, 45, 0, '2023-05-21 10:00:00', '2023-05-21 12:00:00','2023-04-21 08:30:00', '2023-05-21 08:30:00'),
('Evento 2', 2, 17, 0, '2023-05-22 14:00:00', '2023-05-22 16:00:00','2023-04-22 12:30:00', '2023-05-22 12:30:00'),
('Evento 3', 3, 80, 0, '2023-05-23 09:30:00', '2023-05-23 11:30:00','2023-04-23 09:00:00', '2023-05-23 09:00:00'),
('Evento 4', 4, 18, 0, '2023-05-24 16:30:00', '2023-05-24 18:30:00','2023-04-24 16:00:00', '2023-05-24 16:00:00'),
('Evento 5', 1, 38, 0, '2023-05-25 13:00:00', '2023-05-25 15:00:00','2023-04-25 12:30:00', '2023-05-25 12:30:00'),
('Evento 6', 2, 10, 0, '2023-05-26 11:00:00', '2023-05-26 13:00:00','2023-04-26 10:30:00', '2023-05-26 10:30:00');







# Selects

# 1
select l.nomelocal
from local l
inner join evento e on l.id = e.localFK;

#2
select l.nomelocal
from local l
left join evento e on l.id = e.localFK
where e.id is null;

# 3
select * from evento
where diaHoraInicioEv >= '2023-05-21 10:00:00' and diaHoraFinalEv <= '2023-05-21 12:00:00';

# 4
select u.nome from user u
inner join ticket t on u.id = t.userFK;

# 5
select e.nomeEvento, u.nome from Evento e
inner join ticket t on e.id = t.eventoFK
inner join user u on t.userFK = u.id
where t.horarioEmissão < e.diaHoraInicioEv;

# 6
select u.nome, count(t.id) as NumeroDeRegistros
from user u
left join ticket t on u.id = t.userFK
group by u.id;

# 7
select e.nomeEvento, count(t.id) as NumeroDeCheckins
from Evento e
left join ticket t on e.id = t.eventoFK
group by e.id
order by NumeroDeCheckins desc
limit 1;

# 8
select e.nomeEvento, count(t.id) AS NumeroDeCheckins
from Evento e
left join ticket t on e.id = t.eventoFK
group by e.id
order by NumeroDeCheckins asc
limit 1;

# 9
select l.nomelocal, avg(e.vagasOcupadas) as MediaParticipantes
from local l
left join evento e on l.id = e.localFK
group by l.id;

# 10
select e.nomeEvento
from evento e
where e.vagasOcupadas < e.totVagas and e.finalCheckin > now();

# 11
select e.nomeEvento
from evento e
where e.vagasOcupadas >= e.totVagas and e.diaHoraInicioEv > now();

# 12
select e.nomeEvento
from evento e
where e.vagasOcupadas < e.TotVagas and e.finalCheckin > now();

# 13
select u.nome
from user u
inner join ticket t on u.id = t.userFK
where u.dataDeCadastro between '2023-05-23 09:30:00' AND '2023-05-23 11:30:00'
group by u.id
having count(t.id) >= 2;

