-- Criação do DB para cenário de E-commerce de Informática

create database if not exists ecommerce default character set UTf8;
/* =======================================================================================================================
Usar default character set UTf8 para definir que o conjunto de caracteres padrão para todas as colunas de texto será utf8.
É o mesmo que dizer que os textos inseridos serão armazenados e interpretados usando a codificação UTF-8, assim garante a
compatibilidade com diferentes idiomas e sistemas.
======================================================================================================================= */

show databases; -- Para confirmar que o DB foi criado com sucesso.
use ecommerce;

------------------
-- Criar tabela PF
------------------
create table if not exists clientPF (
	idPF int auto_increment primary key,
	Pname VARCHAR(20) NULL,
	Minit varchar(3),
	Lname varchar(20),
    Bdate Date,
	CPF char(11) NOT NULL unique)
ENGINE = InnoDB;
/* O InnoDB oferece desempenho robusto e é ideal para aplicativos que exigem
confiabilidade, como sistemas de gerenciamento de bancos de dados relacionais. */

------------------
-- Criar tabela PJ
------------------
create table if not exists clientPJ (
	idPJ int auto_increment primary key,
	Razao_Social_PJ VARCHAR(45) NULL,
	CNPJ_Client VARCHAR(15) NOT NULL unique)
ENGINE = InnoDB;

-----------------------
-- Criar tabela Cliente
-----------------------
create table if not exists clients(
	idClient int auto_increment primary key,
    identification ENUM ('PF', 'PJ') NOT NULL,
    Phone varchar(15),
    Address varchar(255),
	idPFClient int,
	idPJClient int,	
	constraint fk_client_pf foreign key (idPFClient) references clientPF (idPF),
	constraint fk_client_pj foreign key (idPJClient) references clientPJ (idPJ))        
ENGINE = InnoDB;

--------------------------
-- Criar tabela Fornecedor
--------------------------
create table if not exists supplier (
	idSupplier int auto_increment primary key,
	Razao_Social_Supplier VARCHAR(45) NOT NULL,
	CNPJ_Supplier VARCHAR(15) NOT NULL,
	Phone varchar(15),
	Address varchar(255))
ENGINE = InnoDB;

-----------------------
-- Criar tabela Produto
-----------------------
create table if not exists products (
	idProduct int auto_increment primary key,
	PnameProduct varchar(20) NOT NULL,
    Weight float NULL,
    DimensionProduct varchar(50) NULL,
    Category ENUM('Eletrônico', 'Computador', 'Impressora', 'Periféricos', 'Games e afins', 'Armazenamento',
    'Multimídia', 'Software', 'Celulares e afins', 'Redes', 'Outros'),
    Price float,
    Packaging ENUM('Sim', 'Não'))
ENGINE = InnoDB;

-----------------------
-- Criar tabela Pedido
-----------------------
create table if not exists orders (
	idOrder int auto_increment primary key,
	idOrderClient INT,
	StatusOrder ENUM('Cancelado', 'Confirmado', 'Em processamento', 'Enviado', 'Entregue') NOT NULL,
	OrderDescription varchar(255) NULL,
	Assessment float default 10,
    Priority ENUM('Baixa', 'Média', 'Alta') NULL DEFAULT 'Baixa',
	constraint fk_order_client foreign key (idOrderClient) references clients (idClient))
ENGINE = InnoDB;

-----------------------
-- Criar tabela Estoque
-----------------------
create table if not exists stock (
	idStock int auto_increment primary key,
	AddressStock VARCHAR(45) NOT NULL,
    Amount INT NOT NULL)
ENGINE = InnoDB;

-----------------------
-- Criar tabela Entrega
-----------------------
create table if not exists delivery (
	idDelivery int auto_increment primary key,
	orderDate DATE NOT NULL,
	shippingDate DATE NULL,
	deliveryDate DATE NULL,
	trackingCode VARCHAR(45) NULL,
	descriptionDelivery VARCHAR(45) NULL,
	deliveryPedido int,
	deliveryClient int,
	constraint fk_delivery_order foreign key (deliveryPedido) references orders (idOrder),
	constraint fk_delivery_client foreign key (deliveryClient) references clients (idClient))
ENGINE = InnoDB;

-------------------------
-- Criar tabela Pagamento
-------------------------
create table if not exists payment (
	idPayment int auto_increment primary key,
	paymentMethod ENUM('Boleto', 'Cartão', 'PIX') NOT NULL,
	paymentOrder int,
	paymentClient int,
	constraint fk_payment_order foreign key (paymentOrder) references orders (idOrder),
	constraint fk_payment_client foreign key (paymentClient) references clients (idClient))
ENGINE = InnoDB;

-------------------
-- Criar tabela PIX
-------------------
create table if not exists pix (
	idPix int auto_increment primary key,
    paymentPix int,
	orderPix int,
	clientPix int,
    constraint fk_payment_pix foreign key (paymentPix) references payment (idPayment),
	constraint fk_order_pix foreign key (orderPix) references orders (idOrder),
	constraint fk_client_pix foreign key (clientPix) references clients (idClient))
ENGINE = InnoDB;

----------------------
-- Criar tabela Boleto
----------------------
create table if not exists ticket (
	idTicket int auto_increment primary key,
	valueTicket float NOT NULL,
	dueDate Date NOT NULL,
	paymentDate Date NOT NULL,
	requestApproved ENUM('Sim', 'Não') NOT NULL,
	ticketPayment int,
	ticketOrder int,
	ticketClient int,
	constraint fk_payment_ticket foreign key (ticketPayment) references payment (idPayment),
	constraint fk_order_ticket foreign key (ticketOrder) references orders (idOrder),
	constraint fk_client_ticket foreign key (ticketClient) references clients (idClient))
ENGINE = InnoDB;

----------------------
-- Criar tabela Cartão
----------------------
create table if not exists card (
	idCard int auto_increment primary key,
	valueCard float NOT NULL,
	typeCard ENUM('Crédio', 'Débito') NOT NULL,
	paymentDate Date NOT NULL,
	nCartao VARCHAR(16) NULL,
	compraParcelada ENUM('Sim', 'Não') NOT NULL,
	parcelas ENUM ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10') NOT NULL,
	titular ENUM('Sim', 'Não') NOT NULL,
	fullName VARCHAR(45) NOT NULL,
	cardPayment int,
	cardOrder int,
	cardClient int,
	constraint fk_payment_card foreign key (cardPayment) references payment (idPayment),
	constraint fk_order_card foreign key (cardOrder) references orders (idOrder),
	constraint fk_client_card foreign key (cardClient) references clients (idClient))
ENGINE = InnoDB;

-------------------------------------------
-- Criar tabela Relação Produto Encomendado
-------------------------------------------
create table if not exists productsEncomed (
	idProductEncomed int auto_increment primary key,
	Amount INT NOT NULL,
	ProductEncomedProduct int,
	ProductEncomedOrder int,
	constraint fk_product__encomed_product foreign key (ProductEncomedProduct) references products (idProduct),
	constraint fk_products_encomed_order foreign key (ProductEncomedOrder) references orders (idOrder))
ENGINE = InnoDB;

---------------------------------
-- Criar tabela Vendedor Parceiro
---------------------------------
create table if not exists vendedorParceiro (
	idVendedorParceiro int auto_increment primary key,
    Razao_Social_Parceiro VARCHAR(45) NOT NULL,
	CNPJ_Parceiro VARCHAR(15) NOT NULL)
ENGINE = InnoDB;


--------------------------------------------
-- Criar tabela Relação Produto por Vendedor
--------------------------------------------
create table if not exists productSupplier (
	idProductSupplier int auto_increment primary key,
    Amount INT NOT NULL,
    ProductSupplierParceiro int,
	ProductSupplierProduct int,
	constraint fk_product_supplier_parceiro foreign key (ProductSupplierParceiro) references vendedorParceiro (idVendedorParceiro),
	constraint fk_product_supplier_product foreign key (ProductSupplierProduct) references products (idProduct))
ENGINE = InnoDB;
    
----------------------------------
-- Criar tabela Produto_fornecedor
----------------------------------
create table if not exists products_supplier (
	idSupplierHasProduct int,
	idProductEmSupplier int,
	constraint fk_supplier_has_product foreign key (idSupplierHasProduct) references supplier (idSupplier),
	constraint fk_product_em_supplier foreign key (idProductEmSupplier) references products (idProduct))
ENGINE = InnoDB;

----------------------------------
-- Criar tabela Produto_estoque
----------------------------------
create table if not exists products_stock (
	idProductsStock int,
	idProductsProduct int,
    constraint fk_products_stock foreign key (idProductsStock) references stock (idStock),
	constraint fk_products_product foreign key (idProductsProduct) references products (idProduct))	
ENGINE = InnoDB;