-- criação do banco de dados para o cenário do E-commerce 
create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
		idClient int auto_increment primary key,
        Fname varchar(15),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(30),
        constraint unique_cpf_cliente unique (CPF)
);

-- criar tabela produto

create table product(
		idProduct int auto_increment primary key,
        Pname varchar(15) not null,
        classification_kids bool default false,
        category enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Moveis') not null,
        avaliação float default 0,
        size varchar(10)
);

-- tabela de pagamento 

create table payments(
	idclient int,
    idpayment int,
    typePayment enum('Boleto', 'Cartão', 'Dois cartões'),
    limitAvalible float,
    CreditDate date,
    primary key(idClient, id_payment)
);

-- criar tabela pedido

create table oders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    oderdescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_oders_client foreign key (idOrderClient) references Clients (idClient)
			on update cascade
);


-- criar tabela estoque 

create table productStorage(
	idProductStorage int auto_increment primary key,
	StorageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor 

create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

-- criar tabela vendedor

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15) not null,
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPf)
);

-- criar tabela produtos vendedor

create table productSeller (
	idPseller int,
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
);


-- criar tabela product order

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);


-- criar tabela storage location

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product (idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProductStorage)
);


-- criando tabela product supplier

create table productSupplier(
	idPsSupplier int, 
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);


-- comandos de consulta de tabela

show databases;
show tables;
desc productSupplier;
select *  from referential_constraints;
select *  from referential_constraints where constraint_schema = ecommerce;