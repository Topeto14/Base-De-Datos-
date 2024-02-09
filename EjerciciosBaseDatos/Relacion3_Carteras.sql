CREATE DATABASE if NOT EXISTS Carteros;
USE Carteros;
CREATE TABLE IF NOT EXISTS Provincia (
	Id_prov char(3) NOT NULL primary key,
    Nom_prov varchar(15) NOT NULL
);
describe Provincia ;
CREATE TABLE IF NOT EXISTS Ciudad (
	Id_ciud char(3) NOT NULL primary key,
    nom_ciud varchar(20) NOT NULL,
    Num_hab INT (8) NOT NULL,
    Id_prov char(3) NOT NULL
);
describe Ciudad ;
CREATE TABLE IF NOT EXISTS Cartero (
	Id_cart char(3) NOT NULL primary key,
	Nom_cart varchar(25) NOT NULL,
	Sueldo INT(5) NOT NULL
);
describe Cartero;
CREATE TABLE IF NOT EXISTS Periodos (
	Id_per char(3) NOT NULL primary key,
    Fecha_ini date NOT NULL, 
	Fecha_fin date NOT NULL
);
describe Periodos ;
CREATE TABLE IF NOT exists Zona (
	Id_zona char(3) NOT NULL primary key,
    Nom_zona varchar(10) NOT NULL,
    Id_Ciud char(3) NOT NULL,
    foreign key (Id_Ciud) references Ciudad (Id_ciud)
    on delete cascade,
    primary key (Id_zona,Id_Ciud)
); 
describe Zona ;
CREATE TABLE IF NOT EXISTS Relacion2 (
	Id_zona char (3) NOT NULL,
    Id_ciud char (3) NOT NULL,
    Id_cart char(3) NOT NULL,
    Id_per char(3) NOT NULL,
    primary key(Id_zona, Id_ciud,Id_cart, Id_per),
    foreign key (Id_zona) references Zona (Id_zona)
    on delete cascade,
    foreign key (Id_ciud) references Ciudad (Id_ciud)
    on delete cascade, 
    foreign key (Id_cart) references Cartero (Id_cart)
    on delete cascade,
    foreign key (Id_per) references Periodos (Id_per)
    on delete cascade
);
Describe Relacion2 ;
