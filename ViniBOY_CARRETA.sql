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
    blocoFK bigint not null,
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

