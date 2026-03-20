-- Criação do DB para cenário de Oficina Mecânica para carros e motos

create database if not exists oficina default character set UTF8MB4;

show databases; -- Para confirmar que o DB foi criado com sucesso.
use oficina;

------------------
-- Criar tabela PF
------------------
create table if not exists clientPF (
    idPF int auto_increment primary key,
	fullName VARCHAR(45) NOT NULL,
	CPF char(11) NOT NULL unique)
ENGINE = InnoDB;

------------------
-- Criar tabela PJ
------------------
create table if not exists clientPJ (
	idPJ int auto_increment primary key,
	Razao_Social VARCHAR(45) NULL,
	CNPJ_Client VARCHAR(15) NOT NULL unique)
    
ENGINE = InnoDB;

------------------------------
-- Criar tabela Cadastro Geral
------------------------------
create table if not exists cadastro (
	idCadastro int auto_increment primary key,
    identification ENUM ('PF', 'PJ') NOT NULL,
    email varchar(45) NULL,
    Phone varchar(15),
    Address varchar(255),
	idPFCadastro int,
	idPJCadastro int,	
	constraint fk_cadastro_pf foreign key (idPFCadastro) references clientPF (idPF),
	constraint fk_cadastro_pj foreign key (idPJCadastro) references clientPJ (idPJ))        
ENGINE = InnoDB;

----------------------
-- Criar tabela Equipe
----------------------
create table if not exists equipe (
	idEquipe int auto_increment primary key,
    codigoMecanico varchar(15) not null unique,
    especialidade varchar(45) not null)
ENGINE = InnoDB;

------------------------
-- Criar tabela Veículo
------------------------
create table if not exists veiculo (
	idVeiculo int auto_increment primary key,
	Placa varchar(7) NOT NULL,
	CRLV varchar(45) NOT NULL,
	TipoVeiculo enum('Moto', 'Carro') NOT NULL,
	AnoVeiculo int NOT NULL,
	CorVeiculo varchar(15) NOT NULL,
	Marca varchar(20) NOT NULL,
	Hodometro varchar(6) NOT NULL,
	idCadastroVeiculo int,
	idPJVeiculo int,
	idPFVeiculo int,
    constraint fk_veiculo_cadastro foreign key (idCadastroVeiculo) references cadastro (idCadastro),
    constraint fk_veiculo_pf foreign key (idPJVeiculo) references clientPF (idPF),
	constraint fk_cadastro_pj foreign key (idPFVeiculo) references clientPJ (idPJ))
ENGINE = InnoDB;

-------------------------------
-- Criar tabela Equipe mecânica
-------------------------------
create table if not exists equipeMecanica (
	idEquipeMecanica int auto_increment primary key,
	Avaliacao varchar(45) NOT NULL,
	TabelaMaoObra float NOT NULL,
	GerarOS enum('Sim', 'Não') NOT NULL,
	idMecanicoEquipe int,
	constraint fk_mecanico_equipe foreign key (idMecanicoEquipe) references equipe (idEquipe))
ENGINE = InnoDB;

-------------------------
-- Criar tabela Orçamento
-------------------------
create table if not exists orcamento (
	idOrcamento int auto_increment primary key,
	Aprovacao ENUM('Sim', 'Não') NOT NULL,
	DataOrcamento DATE NOT NULL,
	ValorOrcamento float NOT NULL,
	ValidadeOrcamento enum('10 dias', '20 dias', '30 dias') NOT NULL,
	idOrcamentoCadastro int,
	idOrcamentoidPJ int,
	idOrcamentoidPF int,
	constraint fk_orcamento_cadastro foreign key (idOrcamentoCadastro) references cadastro (idCadastro),
	constraint fk_orcamento_pf foreign key (idOrcamentoidPJ) references clientPF (idPF),
	constraint fk_orcamentoo_pj foreign key (idOrcamentoidPF) references clientPJ (idPJ))
ENGINE = InnoDB;

--------------------------------
-- Criar tabela Ordem de Serviço
--------------------------------
create table if not exists ordemServico (
	idOrdem int auto_increment primary key,
	nOS varchar(45) NULL,
	Emissao DATE NOT NULL,
	PrevisaoEntrega DATE NULL,
	ValorPecas float NULL,
	ValorMO float NULL,
	idOSVeiculo int,
	idOSCadastro int,
	idOSPJ int,
	idOSPF int,
	idOSEquipe int,
	idOSOrcamento int,
	constraint fk_ordem_veiculo foreign key (idOSVeiculo) references veiculo (idVeiculo),
	constraint fk_ordem_cadastro foreign key (idOSCadastro) references cadastro (idCadastro),
	constraint fk_ordem_pj foreign key (idOSPJ) references clientPF (idPF),
	constraint fk_ordem_pf foreign key (idOSPF) references clientPJ (idPJ),
	constraint fk_ordem_equipe foreign key (idOSEquipe) references equipeMecanica (idEquipeMecanica),
	constraint fk_ordem_orcamento foreign key (idOSOrcamento) references orcamento (idOrcamento))
ENGINE = InnoDB;

---------------------------
-- Criar tabela Tabela M.O.
---------------------------
create table if not exists tabelamaoobra (
	idTabelaMO int auto_increment primary key,
	Especialidade enum('Elétrica', 'Fluídos', 'Freios', 'Suspensão', 'Motor', 'Geral') NOT NULL,
	Pecas varchar(45) NOT NULL,
	QuantidadePecas int NOT NULL,
	PrecoPeca float NOT NULL,
	ValorMO float NOT NULL,
	Total float NOT NULL)    
ENGINE = InnoDB;

-----------------------
-- Criar tabela Estoque
-----------------------
create table if not exists estoque (
	idEstoque int auto_increment primary key,
	NomePeca varchar(25) NOT NULL,
	Quantidade int NOT NULL,
	ValorPeca float NOT NULL,
	Solicitante varchar(20) NOT NULL)  
ENGINE = InnoDB;

-------------------------------------
-- Criar tabela Execução dos Serviços
-------------------------------------
create table if not exists execucaoServico (
	idExecucao int auto_increment primary key,
	Conclusao Date NULL,
    idExecucaoVeiculo int,
	idExecucaoCadastro int,
	constraint fk_ordem_veiculo foreign key (idOSVeiculo) references veiculo (idVeiculo),
	constraint fk_ordem_cadastro foreign key (idOSCadastro) references cadastro (idCadastro))
ENGINE = InnoDB;

--------------------------------------------
-- Criar tabela Ordem de Serviço Tem Estoque
--------------------------------------------
create table if not exists ordemTemEstoque (
	idOrdemServicoEstoque int,
    idOrdemServicoOrcamento int,
    idOrdemServicoServico int,
    constraint fk_ostemestoque_estoque foreign key (idOrdemServicoEstoque) references estoque (idEstoque),
	constraint fk_ostemestoque_orcamento foreign key (idOrdemServicoOrcamento) references orcamento (idOrcamento),
    constraint fk_ostemestoque_servico foreign key (idOrdemServicoServico) references ordemServico (idOrdem))
ENGINE = InnoDB;
	
-------------------------------------------
-- Criar tabela Relação M.O._has_Orçamento
-------------------------------------------
create table if not exists mobraorcamento (
	idMOTabelaMO int,
    idMOORcamento int,
    constraint fk_moorcamento_tabelamo foreign key (idMOTabelaMO) references tabelamaoobra (idTabelaMO),
    constraint fk_moorcamento_orcamento foreign key (idMOORcamento) references orcamento (idOrcamento))
ENGINE = InnoDB;