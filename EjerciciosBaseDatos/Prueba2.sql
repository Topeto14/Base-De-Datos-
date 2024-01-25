CREATE DATABASE if not exists ejercicio_1 ;
USE ejercicio_1 ;
CREATE TABLE if not exists clientes (
	NIF CHAR(9) primary key,
    NOMBRE VARCHAR(25) NOT NULL,
    DOMICILIO VARCHAR(100),
    TELF VARCHAR(25),
    CIUDAD VARCHAR (50)
);
describe clientes;
CREATE TABLE if not exists productos(
	CODIGO CHAR(4) primary key,
	DESCRIPCION VARCHAR(100) NOT NULL,
    PRECIO FLOAT,
    STOCK FLOAT,
    MINIMO FLOAT,
    CHECK (PRECIO>0)
);
describe productos;
CREATE TABLE if not exists facturas(
	NUMERO INT primary key, 
	FECHA DATE,
	PAGADO BOOL,
	TOTAL_PRECIO FLOAT,
	NIF_cliente CHAR(9),
	foreign key (NIF_cliente) references clientes(NIF) 
	on delete cascade 
	on update cascade
);
describe facturas;
CREATE TABLE if not exists detalle(
	NUMERO INT ,
	CODIGO CHAR(4),
	UNIDADES INT,
	foreign key (NUMERO) references facturas(NUMERO)
	on delete cascade 
	on update cascade,
	foreign key (CODIGO) references productos(CODIGO)
	on delete cascade 
	on update cascade,
	primary key (NUMERO,CODIGO)
);
describe detalle ;