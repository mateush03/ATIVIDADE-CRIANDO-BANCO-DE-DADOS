

use Oficina_Dio;

create table cliente (
	idcli int auto_increment primary key,
	Nomecli varchar(100),
    CPF_CNPJ char(15) not null,
    contato char(11),
	endereço varchar (255),
    constraint unique_cpf_cnpj_cliente unique (CPF_CNPJ));
    alter table cliente auto_increment =1;

    
create table pedido(
	idped int auto_increment,
    idpedcli int,
	serviço enum ('regulagem', 'motor', 'balanceamento','suspensão', 'troca de oleo'),
    data_solicitacao date,
    primary key (idped, idpedcli),
    constraint fk_prodcli_pedido foreign key (idpedcli) references cliente (idcli));
     alter table cliente auto_increment =1;
    

create table mecanico(
	nomemec varchar (50),
	idmec int auto_increment,
    idpedmec int,
    endereço varchar (255),
    especialidade enum('moto', 'carro', 'caminhão','todos'),
    primary key (idmec, idpedmec),
    constraint fk_idpedmec_mecanico foreign key (idpedmec) references pedido (idped));
    
    
create table peçass(
	idpeça int auto_increment primary key,
    nomepec varchar (50),
    valorpec decimal(10,2));
    alter table peçass auto_increment = 1;
    

create table qtdpeça_pedido(
	idped_qtd int,
    idpeça_qtd int,
    qtdpeça int,
    localização varchar	(50),
    primary key (idped_qtd,idpeça_qtd),
    constraint fk_ideped_qtd_pedido foreign key (idped_qtd) references pedido (idped),
    constraint fk_idpeça_peça foreign key (idpeça_qtd) references peçass (idpeça));
	
create table OrdemServiço(
		idOs int auto_increment,
        status enum('finalizado', 'em manutenção', 'aguardando mecanico') default 'aguardando mecanico',
        data_emissao date not null,
        valor decimal(10,2) not null,
        data_conclusao date,
        idOsped int,
        idOscli int,
        primary key (idOs, idOsped, idOscli),
        constraint fk_idos_pedido foreign key (idOsped) references pedido (idped),
        constraint fk_idos_cli foreign key (idOscli) references cliente (idcli));
        alter table OrdemServiço auto_increment = 1;
        
        
insert into cliente(Nomecli,CPF_CNPJ,contato,endereço)
				values('Maria', '182374980', '85999872301', 'rua de prata 29, carongola - cidade das flores'),
                ('Matheus', '678345092', '85988907261', 'avenida elemeda vinha 1009, centro - cidade das flores'),
                ('Ricardo', '000977621921435', '85984056804', 'avenida elemeda vinha 1009, centro - cidade das flores'),
                ('Julia', '878926108', '85984390512','rua laranjeiras 861, centro - cidade das flores'),
                ('marcelo', '14294314851', '85934812348','rua bela vista 861, centro - maranguape'),
                ('julio', '72618341283', '85934815555','rua argentina 861, centro - pacajus');
                
                
insert into pedido(idpedcli,serviço,data_solicitacao)
			values  (1,'regulagem','2024-02-08'),
					(2,'motor','2024-02-05'),
                    (3,'balanceamento','2024-02-01'),
					(4,'suspensão','2024-01-31'),
                    (5,'troca de oleo','2024-01-30'),
                    (6,'regulagem','2024-02-08');

insert into mecanico(nomemec,idpedmec,endereço,especialidade)
			values  ('Ronaldo',1,'rua minas gerais - cidade das flores', 'moto'),
					('Jailson',2,'rua dos estados - centro', 'carro'),
                    ('Geraldo',3,'av jose bastos - benfica', 'todos'),
                    ('Ricardão',4,'av joao pessoa - damas', 'todos'),
					('Manuel',5,'av 13 de maio - benfica', 'caminhão'),
                    ('Alcidez',5,'rua pereira - meireles', 'caminhão');

						
insert into peçass(nomepec,valorpec)
			values  ('Pistão', '10.00'),
					('Válvula', '150.00'),
                    ('Vela ', '100.00'),
					('Biela ', '9.00'),
					('Bloco do motor', '1000.00'),
                    ('filtro de óleo', '5.50'),
					('Radiador', '20.70');
                    
insert into qtdpeça_pedido(idped_qtd,idpeça_qtd,qtdpeça,localização)
			values  (1,4,4,'armazem 1'),
					(2,7,5,'armazem 2'),
                    (3,5,28,'armazem 1'),
                    (4,6,41,'armazem 1'),
                    (5,2,19,'armazem 2'),
                    (6,5,9,'armazem 1');

insert into OrdemServiço (status,data_emissao,data_conclusao,idOsped,idOscli,valor)
					values ('aguardando mecanico','2024-02-08',null,1,1,'2000.00'),
							('finalizado','2024-02-05','2024-02-06',2,2,'3000.00'),
                            ('finalizado','2024-02-02','2024-02-08',3,3,'10000.00'),
                            ('em manutenção','2024-01-31',null,4,4,'9000.00'),
                            ('em manutenção','2024-01-31',default,5,5,'7000.00'),
							('finalizado','2024-02-08','2024-02-08',6,6,'500.00');
 
 
 -- estoque de peças
select nomepec,qtdpeça,valorpec,localização from qtdpeça_pedido q, peçass p
where p.idpeça = q.idpeça_qtd 
order by qtdpeça desc;
            
 -- identificar em qual pedido o mecanico foi alocado

select idped, nomemec, especialidade, serviço, data_solicitacao
from mecanico m inner join pedido p
on m.idpedmec = p.idped;

-- ordendando valor da peça
select * from peçass
order by valorpec desc;

-- quantidade de pedidos
select count(*) from pedido;

-- agrupando ordem de serviço por status

select count(*) as 'qtd',status from OrdemServiço
group by status;

