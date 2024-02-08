CREATE database IF NOT EXISTS tienda ;
USE tienda ;
CREATE table if not exists fabricantes (
	Clave_fabricante int (4) not null primary key, 
    Nombre varchar (30)
    );
describe fabricantes ;
CREATE TABLE IF NOT exists Articulos (
Clave_articulo int (4) not null  primary key,
Nombre Varchar(30),
Precio int (4),
Clave_fabricante int (4) not null ,
foreign key (Clave_fabricante) references fabricantes (Clave_fabricante)
on delete cascade
on update cascade
);
describe Articulos;