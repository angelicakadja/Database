-- Persistindo dados no DB

show databases; 
use ecommerce;
show tables;

------------------
-- Tabela PF
------------------
insert into clientPF (Pname, Minit, Lname, Bdate, CPF) 
	   values('Maria','M','Silva', '1979-05-28', 12346789),
		     ('Matheus','O','Pimentel', '1990-07-30', 987654321),
			 ('Ricardo','F','Silva', '1950-08-24', 45678913),
			 ('Julia','S','França', '1983-01-29', 789123456),
			 ('Roberta','G','Assis', '2000-04-21', 98745631),
			 ('Isabela','M','Cruz', '1994-03-03', 654789123);

------------------
-- Tabela PJ
------------------
insert into clientPJ (Razao_Social_PJ, CNPJ_Client) 
	values ('Comércio Silva LTDA', '12345678000199'),
		   ('Pimentel e Associados SA', '98765432000110'),
		   ('Silva e Filho ME', '45678901000123'),
		   ('França Importações LTDA', '78912345000167'),
		   ('Assis Distribuidora EIRELI', '98745631000189'),
		   ('Cruz Logística SA', '65478912000134');

-----------------------
-- Tabela Cliente
-----------------------
insert into Clients (identification, Phone, Address, idPFClient, idPJClient)
	values ('PF', '12345-6789', 'Rua das Flores, 123', 1, NULL),
		   ('PJ', '98765-4321', 'Avenida Central, 456', NULL, 1),
		   ('PF', '55555-8888', 'Travessa dos Anjos, 789', 2, NULL),
		   ('PJ', '11111-2222', 'Praça do Sol, 101', NULL, 2),
		   ('PF', '33333-4444', 'Alameda Verde, 202', 3, NULL),
		   ('PJ', '66666-7777', 'Rodovia Branca, 303', NULL, 3);

--------------------------
-- Tabela Fornecedor
--------------------------
insert into supplier (Razao_Social_Supplier, CNPJ_Supplier, Phone, Address)
	values ('Fornecedora Silva LTDA', '12345678000112', '12345-6789', 'Rua das Flores, 123'),
		   ('Pimentel Distribuidora SA', '98765432000134', '98765-4321', 'Avenida Central, 456'),
		   ('Silva e Cia ME', '45678901000156', '55555-8888', 'Travessa dos Anjos, 789'),
		   ('França Logística LTDA', '789123450001-78', '11111-2222', 'Praça do Sol, 101'),
		   ('Assis Comércio EIRELI', '987456310001-90', '33333-4444', 'Alameda Verde, 202'),
		   ('Cruz Importações SA', '65478912000112', '66666-7777', 'Rodovia Branca, 303');

-----------------------
-- Tabela Produto
-----------------------
insert into products (PnameProduct, Weight, DimensionProduct, Category, Price, Packaging)
	values ('Notebook Pro', 1.5, '35x25x2 cm', 'Computador', 5000.00, 'Sim'),
		   ('Smartphone X', 0.2, '15x7x0.8 cm', 'Celulares e afins', 3200.00, 'Sim'),
		   ('Impressora 3D', 8.0, '50x40x40 cm', 'Impressora', 12000.00, 'Sim'),
		   ('Monitor HD', 3.2, '45x30x5 cm', 'Multimídia', 1500.00, 'Não'),
		   ('Controle Gamer', 0.3, '20x10x5 cm', 'Games e afins', 350.00, 'Sim'),
		   ('HD Externo 1TB', 0.5, '10x8x3 cm', 'Armazenamento', 500.00, 'Não');

-----------------------
-- Tabela Pedido
-----------------------
insert into orders (idOrderClient, StatusOrder, OrderDescription, Assessment, Priority)
	values (1, 'Confirmado', 'Compra de eletrônicos diversos', 9.5, 'Média'),
		   (2, 'Enviado', 'Pedido de acessórios para celular', 10, 'Alta'),
		   (3, 'Cancelado', 'Assinatura de serviço mensal', 8.0, 'Baixa'),
		   (4, 'Entregue', 'Aquisição de equipamentos de rede', 10, 'Média'),
		   (5, 'Em processamento', 'Solicitação de software personalizado', 9.0, 'Alta'),
		   (6, 'Confirmado', 'Compra de periféricos para computador', 10, 'Baixa');

-----------------------
-- Tabela Estoque
-----------------------
insert into stock (AddressStock, Amount)
	values ('Rua das Flores, 123', 150),
		   ('Avenida Central, 456', 200),
		   ('Travessa dos Anjos, 789', 75),
		   ('Praça do Sol, 101', 120),
		   ('Alameda Verde, 202', 90),
		   ('Rodovia Branca, 303', 300);

-----------------------
-- Tabela Entrega
-----------------------
insert into delivery (orderDate, shippingDate, deliveryDate, trackingCode, descriptionDelivery, deliveryPedido, deliveryClient)
	values ('2025-04-01', '2025-04-02', '2025-04-05', 'TRK123456', 'Entrega de eletrônicos', 1, 1),
		   ('2025-04-03', '2025-04-04', '2025-04-07', 'TRK987654', 'Entrega de acessórios', 2, 2),
		   ('2025-04-05', NULL, NULL, NULL, 'Entrega pendente', 3, 3),
		   ('2025-03-28', '2025-03-30', '2025-04-02', 'TRK456789', 'Equipamentos de rede', 4, 4),
		   ('2025-03-25', '2025-03-27', NULL, 'TRK654321', 'Software personalizado', 5, 5),
		   ('2025-04-06', '2025-04-07', '2025-04-10', 'TRK789123', 'Periféricos para PC', 6, 6);
       
-------------------------
-- Tabela Pagamento
-------------------------
insert into payment (paymentMethod, paymentOrder, paymentClient)
	values ('Boleto', 1, 1),
		   ('Cartão', 2, 2),
		   ('PIX', 3, 3),
		   ('Cartão', 4, 4),
		   ('Boleto', 5, 5),
		   ('PIX', 6, 6);

-------------------
-- Tabela PIX
-------------------
insert into pix (paymentPix, orderPix, clientPix)
	values (1, 1, 1),
		   (2, 2, 2);

----------------------
-- Tabela Boleto
----------------------
insert into ticket (valueTicket, dueDate, paymentDate, requestApproved, ticketPayment, ticketOrder, ticketClient)
	values (150.75, '2025-04-15', '2025-04-14', 'Sim', 1, 1, 1),
		   (250.50, '2025-05-10', '2025-05-09', 'Não', 2, 2, 2);

----------------------
-- Tabela Cartão
----------------------
insert into card (valueCard, typeCard, paymentDate, nCartao, compraParcelada, parcelas, titular, fullName, cardPayment, cardOrder, cardClient)
	values (1500.50, 'Crédito', '2025-04-12', '1234567890123456', 'Sim', '3', 'Sim', 'João Silva', 1, 1, 1),
		   (800.75, 'Débito', '2025-04-13', NULL, 'Não', '1', 'Não', 'Maria Oliveira', 2, 2, 2);

ALTER TABLE card MODIFY COLUMN typeCard ENUM('Crédito', 'Débito') NOT NULL;

-------------------------------------------
-- Tabela Relação Produto Encomendado
-------------------------------------------
insert into productsEncomed (Amount, ProductEncomedProduct, ProductEncomedOrder)
	values (10, 1, 1),
		   (5, 2, 1),
		   (20, 3, 2),
		   (15, 4, 3),
		   (8, 5, 4),
		   (12, 6, 5);

---------------------------------
-- Tabela Vendedor Parceiro
---------------------------------
insert into vendedorParceiro (Razao_Social_Parceiro, CNPJ_Parceiro)
	values ('Comércio Silva e Cia', '12345678000112'),
	('Pimentel Distribuidora', '98765432000134'),
	('Fornecedora Assis LTDA', '45678901000156'),
	('Logística França', '78912345000178'),
	('Cruz Comércio EIRELI', '98745631000190'),
	('Global Networks SA', '65478912000112');

--------------------------------------------
-- Tabela Relação Produto por Vendedor
--------------------------------------------
insert into productSupplier (Amount, ProductSupplierParceiro, ProductSupplierProduct)
	values (50, 1, 1),
		   (30, 2, 2),
		   (100, 3, 3),
		   (75, 4, 4),
		   (45, 5, 5),
		   (60, 6, 6);
    
----------------------------------
-- Tabela Produto_fornecedor
----------------------------------
insert into products_supplier (idSupplierHasProduct, idProductEmSupplier)
	values (1, 1),
		   (2, 2),
		   (3, 3),
		   (4, 4),
		   (5, 5),
		   (6, 6);

----------------------------------
-- Tabela Produto_estoque
----------------------------------
insert into products_stock (idProductsStock, idProductsProduct)
	values (1, 1),
		   (2, 2),
		   (3, 3),
		   (4, 4),
		   (5, 5),
		   (6, 6);


-- Queries criadas:

select * from products;

select count(*) from clients;

select * from clientpf c, orders o where c.idPF = idOrderClient;
select * from clientpj c, orders o where c.idPJ = idOrderClient;

select Pname, Lname, idOrder, StatusOrder from clientpf c, orders o where c.idPF = idOrderClient;
select Razao_Social_PJ, CNPJ_Client, idOrder, StatusOrder from clientpj c, orders o where c.idPJ = idOrderClient;
                             
select count(*) from clients c, orders o where c.idClient = idOrderClient;

-- recuperação de pedido com produto associado
select * from clients c inner join orders o ON c.idClient = o.idOrderClient; 
        
-- Recuperar quantos pedidos foram realizados pelos clientes?
select c.idPFClient, identification, count(*) as Number_of_orders from clients c 
				inner join orders o ON c.idClient = o.idOrderClient group by idClient; 