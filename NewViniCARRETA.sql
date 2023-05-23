drop database execAcom3smokes;
create database execAcom3smokes;
use execAcom3smokes;

create table lTIPO_EMPRESA(
	idTIPO_EMPRESA int not null,
    DescricaoTipo varchar(30),
    primary key(idTIPO_EMPRESA)
);

create table lSETOR(
	idSETOR int not null,
    NomeSetor varchar(30),
    primary key(idSETOR)
);

create table lCLIENTE(
	idCLIENTE int not null,
    idSetor_FK int not null,
    idTipo_Empresa_FK int not null,
    Nome_RazaoSocial varchar(50),
    Endereco varchar(50),
    Cidade varchar(60),
    UF char(2),
    CEP char(8),
    primary key(idCLIENTE),
    foreign key(idSetor_FK) references lSETOR(idSETOR),
    foreign key(idTipo_Empresa_FK) references lTIPO_EMPRESA(idTIPO_EMPRESA)
);

create table lSOFTWARE(
	idSOFTWARE int not null,
    NomeSoftware varchar(45),
    primary key(idSOFTWARE)
);

create table lVERSAO(
    Versao varchar(20),
    idSOFTWARE_FK int not null,
    primary key(Versao),
    foreign key(idSOFTWARE_FK) references lSOFTWARE(idSOFTWARE)
);

create table lLICENCA(
	NunLicenca varchar(30),
    idCLIENTE_FK int not null,
    idSOFTWARE_FK_FK int not null,
    Versao_FK varchar(20) not null,
    DtAquisicao varchar(45),
    ValorAquisicao numeric(10,2),
	primary key(NunLicenca),
    foreign key(idCLIENTE_FK) references lCLIENTE(idCLIENTE),
    foreign key(idSOFTWARE_FK_FK) references lVERSAO(idSOFTWARE_FK)
);

select *from lCLIENTE;