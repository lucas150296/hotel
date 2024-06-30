
CREATE SCHEMA hospedar_db;
USE hospedar_db;
-- DROP SCHEMA hospedar_db;
/*
	Tabela "Hotel":
	hotel_id (Chave primária, INT): Identificador único do hotel.
	nome (VARCHAR, não nulo): Nome do hotel.
	cidade (VARCHAR, não nulo): Cidade onde o hotel está localizado.
	uf (VARCHAR, não nulo): Estado onde o hotel está localizado, com dois dígitos.
	classificacao (INT, não nulo): Classificação do hotel em estrelas (1 até 5).
*/

-- DROP TACLE Hotel;
CREATE TABLE Hotel(
	hotel_id int auto_increment primary key ,
    nome varchar(100) not null,
    cidade varchar(100) not null,
    uf varchar(2) not null,
    classificacao int (1) not null
); 

/*
	Tabela "Quarto":
	quarto_id (Chave primária, INT): Identificador único do quarto.
	hotel_id (Chave estrangeira não nula para "Hotel"): Identificador do hotel ao qual o quarto pertence.
	número (INT, não nulo): Número do quarto.
	tipo (VARCHAR, não nulo): Tipo de quarto (por exemplo, "Standard", "Deluxe", "Suíte").
	preco_diaria (DECIMAL, não nulo): Preço da diária do quarto.
*/

-- DROP TABLE Quarto;
CREATE TABLE Quarto (
	quarto_id int  primary key auto_increment  ,
    hotel_id int not null,
    numero int not null,
    tipo varchar(25) not null,
    preco_diaria float(99,2) not null,
    
    foreign key (hotel_id) references Hotel(hotel_id)
    
);

/*
	Tabela "Cliente":
	cliente_id (Chave primária, INT): Identificador único do cliente.
	nome (VARCHAR, não nulo): Nome do cliente.
	email (VARCHAR, não nulo e único): Endereço de e-mail do cliente.
	telefone (VARCHAR, não nulo): Número de telefone do cliente.
	cpf (VARCHAR, não nulo e único): Número de CPF do cliente.
*/

-- DROP TABLE Cliente;
CREATE TABLE Cliente (
	cliente_id int primary key auto_increment,
    nome varchar(150) not null,
    email varchar(200) not null unique,
    telefone varchar(12) not null,
    cpf varchar(12) not null unique
);

/*
	Tabela "Hospedagem":
	hospedagem_id (Chave primária, INT): Identificador único da hospedagem.
	cliente_id (Chave estrangeira não nula para "Cliente"): Identificador do cliente que fez a reserva.
	quarto_id (Chave estrangeira não nula para "Quarto"): Identificador do quarto reservado.
	dt_checkin (DATE): Data de check-in da hospedagem (não nula).
	dt_checkout (DATE): Data de check-out da hospedagem (não nula).
	Valor_total_hosp(FLOAT, não nulo): Custo total da hospedagem, calculado quando a hospedagem é finalizada.
	status_hosp (VARCHAR, não nulo):
    
    status_hosp da hospedagem, 
    podendo receber os seguintes valores: “reserva”,
    reservado pelo cliente; “finalizada”,
    hospedagem concluida; “hospedado”,
    o cliente está atualmente hospedado no hotel;
    “cancelada”, a hospedagem (reserva) foi cancelada.
*/

-- DROP TABLE Hospedagem;

CREATE TABLE Hospedagem(
	hospedagem_id int primary key auto_increment,
    cliente_id int not null,
    quarto_id int not null,
    dt_checkin date not null,
    dt_checkout date not null,
    valor_total_hosp float not null,
    status_hosp varchar(15) not null,
    
    foreign key (cliente_id) references Cliente(cliente_id),
    foreign key (quarto_id) references Quarto(quarto_id)
);

-- cadastro de dados nas tabela

use hospedar_db;

insert into Hotel(nome, cidade, uf, classificacao) value ('eliana', 'bahia', 'ba', 5),('bahiamar','salvador','ba' ,3);
insert into Quarto(hotel_id, numero,tipo, preco_diaria) value(1, 1, 'Standard', 30.50),(2, 1, 'Deluxe', 100.50),(1, 2, 'Standard', 30.50),(2, 2, 'Deluxe', 100.50),(2, 3, 'Suíte', 200.00);
insert into Cliente(nome, email, telefone, cpf) value
	('lucas', 'lucas@hotmail.com', '31123456789', '12345678901'),
	('warley', 'warley@hotmail.com', '31987654321','12345678902'),
	('elidia' ,'elidia@hotmail.com','11123456789', '12345678903');

insert into Hospedagem(cliente_id, quarto_id,dt_checkin, dt_checkout, valor_total_hosp, status_hosp) value 
	(1, 1, '2024-01-01', '2024-01-07', 213.50, 'reserva'),
	(2, 2, '2024-02-01', '2024-02-07', 703.50, 'reserva'),
	(3, 3, '2024-03-01', '2024-03-07', 213.50, 'reserva'),
	(2, 4, '2024-04-01', '2024-04-07', 213.50, 'reserva'),
	(1, 5, '2024-05-01', '2024-05-07', 1200.00, 'reserva'),

	(1, 1, '2024-01-01', '2024-01-07', 213.50, 'finalizada'),
	(2, 2, '2024-02-01', '2024-02-07', 703.50, 'finalizada'),
	(3, 3, '2024-03-01', '2024-03-07', 213.50, 'finalizada'),
	(2, 4, '2024-04-01', '2024-04-07', 213.50, 'finalizada'),
	(1, 5, '2024-05-01', '2024-05-07', 1200.00, 'finalizada'),
    
	(1, 1, '2024-01-01', '2024-01-07', 213.50, 'hospedado'),
	(2, 2, '2024-02-01', '2024-02-07', 703.50, 'hospedado'),
	(3, 3, '2024-03-01', '2024-03-07', 213.50, 'hospedado'),
	(2, 4, '2024-04-01', '2024-04-07', 213.50, 'hospedado'),
	(1, 5, '2024-05-01', '2024-05-07', 1200.00, 'hospedado'),
    
	(1, 1, '2024-06-01', '2024-06-07', 213.50, 'cancelada'),
	(2, 2, '2024-07-01', '2024-07-07', 703.50, 'cancelada'),
	(3, 3, '2024-08-01', '2024-08-07', 213.50, 'cancelada'),
	(2, 4, '2024-09-01', '2024-09-07', 213.50, 'cancelada'),
	(1, 5, '2024-10-01', '2024-10-07', 1200.00, 'cancelada');
set SQL_SAFE_UPDATES = 0;
    select h.nome, h.cidade, q.tipo, q.preco_diaria from Hotel h join Quarto q on (q.hotel_id = h.hotel_id);

	select c.nome, q.quarto_id, h.hotel_id from  Hospedagem ho  
		join Cliente c on (c.cliente_id = ho.cliente_id)
		join Quarto q on (q.quarto_id = ho.quarto_id)
		join Hotel h on ( h.hotel_id = q.hotel_id) 
        where ho.status_hosp = 'finalizada';
        
	select h.nome ,sum(valor_total_hosp) as valor_total_hosp  from  Hospedagem ho  
		join Cliente c on (c.cliente_id = ho.cliente_id)
		join Quarto q on (q.quarto_id = ho.quarto_id)
		join Hotel h on ( h.hotel_id = q.hotel_id) 
        where ho.status_hosp = 'finalizada' order by h.nome; 
	
    select * from Hospedagem h where h.cliente_id = 1 order by dt_checkin;
    
    select cliente_id, count(*) as QtdHospedagem 
    from Hospedagem group by cliente_id 
    having count(*) > 1 order by QtdHospedagem desc limit 1;
    
    select c.nome, q.quarto_id, h.hotel_id from  Hospedagem ho  
		join Cliente c on (c.cliente_id = ho.cliente_id)
		join Quarto q on (q.quarto_id = ho.quarto_id)
		join Hotel h on ( h.hotel_id = q.hotel_id) 
        where ho.status_hosp = 'cancelada';
    
    select c.nome, q.quarto_id, h.hotel_id from  Hospedagem ho  
		join Cliente c on (c.cliente_id = ho.cliente_id)
		join Quarto q on (q.quarto_id = ho.quarto_id)
		join Hotel h on ( h.hotel_id = q.hotel_id) 
        where h.hotel_id = 1;
  	select h.nome ,avg(valor_total_hosp) as valor_total_hosp  from  Hospedagem ho  
		join Cliente c on (c.cliente_id = ho.cliente_id)
		join Quarto q on (q.quarto_id = ho.quarto_id)
		join Hotel h on ( h.hotel_id = q.hotel_id) 
        where ho.status_hosp = 'finalizada' order by h.nome;  
        
alter table Hospedagem add column checkin_realizado boolean;
update Hospedagem ho  set checkin_realizado = true where ho.status_hosp = 'finalizada' ;
update Hospedagem ho  set checkin_realizado = true where ho.status_hosp = 'hospedado' ;
update Hospedagem ho  set checkin_realizado = false where ho.status_hosp = 'reserva' ;
    
alter table Hotel rename column classificacao to ratting;

DELIMITER //
create function TotalHospedagensHotel(hotel_id int)
returns int

deterministic
reads sql data

begin
	declare hospedagens int;
	select count(*) as  hospedagens  into hospedagens from  Hospedagem ho  
		join Cliente c on (c.cliente_id = ho.cliente_id)
		join Quarto q on (q.quarto_id = ho.quarto_id)
		join Hotel h on ( h.hotel_id = q.hotel_id) 
        where h.hotel_id = hotel_id;
        
	return hospedagens;
    
END //
DELIMITER ; 

DELIMITER //
create function ValorMedioDiariasHotel(hotel_id int)
returns int

deterministic
reads sql data

begin
	declare media_diaria int;
	select avg(preco_diaria) as media_diaria into media_diaria  from  Hotel h  
		join Quarto q on (q.quarto_id = h.hotel_id)
        where h.hotel_id = hotel_id;
    return media_diaria;
END //
DELIMITER ;   

DELIMITER //
create function VerificarDisponibilidadeQuarto(quarto_id int, dia date)
returns boolean

deterministic
reads sql data

begin
	declare resposta boolean;
	select * from  Quarto q  
        where q.quarto_id = quarto_id;
    return resposta;
END //
DELIMITER ; 

select TotalHospedagensHotel(1);
    

    
	
        
	
