create database formativaBOY;
use formativaBOY;

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
    bloco varchar(1) not null,
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


