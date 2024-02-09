-- criação de banco de dados para o cenário de E-commercer
create database ecommerce_DIO;

use ecommerce_DIO;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
	Fname varchar(10), 
	Minit char(3),
	Lname varchar(20),
	CPF char(11) not null,
    Address varchar(45),
    constraint unique_cliente_cpf unique (CPF));
    
    alter table clients auto_increment = 1;
    alter table clients
    MODIFY Address varchar(255);
    alter table clients
    ADD tipo_pessoa char(2);
-- criar tabela produto
create table product(
	idProduct int auto_increment primary key,
	Pname varchar(10) not null,
	classification_kids bool default false,
	category enum('eletronico', 'vestimenta', 'brinquedos', 'alimentos') not null,
	avaliação float default 0,
    size varchar(10));
    alter table product auto_increment = 1;
    alter table product
    modify category enum('eletronico', 'vestimenta', 'brinquedos', 'alimentos','moveis') not null;
    alter table product 
    modify pname varchar(50);
    -- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	ordersStatus enum('cancelado','confirmado','Em processamento') default 'Em processamento',
    ordersDescroption varchar(255),
    sendValue float default 10,
	constraint fk_orders_client foreign key (idOrderClient) references clients(idClient));
    alter table orders auto_increment = 1;
    -- criar tabela pagamento
create table payments(
	idPayment int ,
    idClientpay int,
    idOrderPay int,
    primary key (idClientpay, idOrderPay),
    TypePayment enum('Dinheiro', 'Cartao de credito', 'Pix', 'Boleto', 'Cartao de debito') NOT null,
    constraint fk_pay_order foreign key (idOrderPay) references orders(idOrder),
    constraint fk_pay_client foreign key (idClientpay) references clients(idClient));
    alter table payments auto_increment = 1;
   
    
    -- criar tabela estoque
create table productStorage(
	idProductStorage int auto_increment primary key,
	locationStore varchar(45),
	quantity int default 0);
	 alter table productStorage auto_increment = 1;
    -- criar tabela fornecedor
create table supplier(
	idSuppplier int auto_increment primary key,
    SocialName varchar (45),
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_cnpj_supp unique (CNPJ));
    alter table supplier auto_increment = 1;
    
	-- criar tabela vendedorr
Create table seller(
	idSeller int auto_increment primary key,
	SocialName varchar(255) not null,
    NameSeller varchar (50) not null,
    CPF char(9),
    CNPJ char(15),
    contact char(11) not null,
    location varchar (255) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF));
alter table seller auto_increment = 1;
alter table seller
modify NameSeller varchar (50);

create table productSeller (
	idPseller int,
    idProduct int,
    prodQuantity int not null,
    primary key (idPseller,idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
    constraint fk_product_product foreign key (idProduct) references product (idProduct));
    
create table productOrder(
	idPOproduct int,
    idPOorder int,
	poQuantity int default 1,
    poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
    primary key (idPoproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product (idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder));

create table storegeLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_Product foreign key (idLproduct) references product (idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage));

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSuppplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct));

show tables;

-- persistindo os dados nas tabela

desc clients;
-- idClient, Fname, Minit, Lname, CPF, Address
insert into clients (Fname, Minit, Lname, CPF, Address,tipo_pessoa)
			values  ('Maria', 'M', 'Silva','55978632145', 'rua de prata 29, carongola - cidade das flores','PJ'),
					('Matheus', 'O', 'Pimentel', '52314897946', 'rua alemeda 289, centro - cidade das flores','PF'),
                    ('Ricardo', 'F','Silva', '45612378964', 'avenida elemeda vinha 1009, centro - cidade das flores','PJ'),
					('Julia', 'S', 'França', '77789645321', 'rua laranjeiras 861, centro - cidade das flores','PJ'),
                    ('Roberta', 'G', 'Assis', '98745521397', 'rua almeida das flores 28, centro - cidade das flores','PJ'),
					('Isabela', 'M', 'Cruz', '45622231658', 'avenida koller 19, centro - cidade das flores','PJ');
                    

  desc product;
  -- Pname, classification_kids, category, avaliação, size
  
insert into product (Pname, classification_kids, category, avaliação, size)
			values	('Fone de Ouvido', false, 'eletronico','4',null),
					('barbie', true, 'brinquedos', '3',null),
                    ('Body Carters', true, 'vestimenta','5',null),
                    ('Microfone', false, 'eletronico', '4', null),
                    ('Sofa Retratil', false, 'moveis', '2', '3x57x80');
                    
insert into product (Pname, classification_kids, category, avaliação, size)
			values	('farinha de arroz', false, 'alimentos','4',null);
            
desc orders;
            
insert into orders (idOrderClient,ordersStatus,ordersDescroption,sendValue)
			values  (1, default, 'Compra via aplicativo', null),
					(2, default, 'Compra via aplicativo', 50),
					(3, 'confirmado',null,null),
                    (4,default,'Compra via web site',150);
                    

insert into payments (idPayment,idClientpay, idOrderPay, TypePayment)
		values (5,1,1,'Dinheiro'),
				(4,2,2, 'Cartao de credito'),
				(3,3,3, 'Pix'),
                (7,4,4, 'Boleto');
		
desc productOrder;

insert into productOrder (idPOproduct,idPOorder, poQuantity, poStatus)
		values  (1,1,2,default),
				(2,2,1,default),
                (3,1,1,'Sem estoque');


insert into productStorage (locationStore, quantity)
			values ('Rio de janeiro', 1000),
					('Rio de janeiro', 100),
                    ('Rio de janeiro', 500),
                    ('Rio de janeiro', 50),
                    ('São paulo', 500),
                    ('Brazilia',60);
desc storegeLocation;

insert into storegeLocation (idLproduct, idLstorage, location)
			values (1,2,'RJ'),
				   (2,6,'GO');
                   
desc supplier;
insert into supplier (SocialName, CNPJ, contact)
			values	('Almeida e filhos', '456789123698751', '41597896514'),
					('Eletronicos silva', '741564789321021','45698896211'),
					('Eletronicos valma', '456988795123025', '74698564621');
                    
desc   productSupplier;                  
	
insert into productSupplier (idPsSupplier, idPsProduct, quantity)
						values (1,1,500),
							   (1,2,400),
                               (2,4,633),
                               (3,3,5),
                               (2,5,10);
                               
desc seller; 

insert into seller (SocialName, NameSeller, CPF, CNPJ, contact, location)
			values ('tech eletronics', null, null,'698536547789210', '88569741120', 'Rio de janeiro'),
					('Botique',null, '605273513', null, '85644425871', 'Rio de janeiro'),
                    ('kids world', null,null, '966874520315468', 1185497559, 'São paulo');
                    
desc productSeller ;

insert into productSeller (idPseller, idProduct, prodQuantity)
	values (2,1,80),
			(1,3,10);

-- quantidade de clientes 
select count(*) 'qtd clientes' from clients;

select * from clients c, orders o where c.idClient = o.idOrderClient;

-- quantidade de itens em estoque por região
select sum(quantity) as 'total qtd', locationStore from productStorage
group by locationStore;
               
 desc clients  ;  
 -- status de pagamento por cliente
Select concat(Fname, ' ', Lname) as Cliente, idOrder, ordersStatus
from clients c, orders o 
where c.idClient = idOrderClient;

desc orders;

-- analise forma de pagameto com status de pagameto
Select concat(Fname, ' ', Lname) as Cliente,  idPayment, TypePayment, CPF, ordersStatus, ordersDescroption from orders o, clients c, payments p 
where  p.idClientpay = c.idClient = o.idOrder;
 
 -- quantidade de pedidos feitos por cada cliente
 Select count(*) as 'total de pedidos' from orders;
 
 -- relação de produtos fonecedores e estoque
select idPsSupplier, idlproduct,quantity,location  from productSupplier p, storegeLocation s
where p.idPsProduct = s.idLproduct ;

-- Relação de nomes dos fornecedores e nomes dos produtos

select distinct (pname),SocialName, CNPJ, category 
	from  productSupplier ps inner join supplier s
	on ps.idPsSupplier =  s.idSuppplier
	inner join product p
    on ps.idPsSupplier = p.idProduct
    
    


 