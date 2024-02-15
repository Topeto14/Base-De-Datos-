create database if not exists relacion_4;
use relacion_4;
create table if not exists mecanico (
id_mec varchar (4) not null primary key,
nom_mec varchar(20),
sueldo int (4),
fec_nac date 
);
describe mecanico;
create table if not exists coche (
mat_co varchar(8) not null primary key,
mod_co varchar (20),
color varchar (10),
tipo varchar(15)
);
describe coche;
create table if not exists periodo(
id_per varchar (3) not null primary key,
fec_ini date,
fec_fin date
);
describe periodo;
create table if not exists pieza (
id_piez varchar (3) not null primary key,
nom_piez varchar(15),
id_tipo varchar(3)
);
describe pieza;
create table if not exists tipo(
id_tipo varchar(3) not null primary key,
nom_tipo varchar(15)
);
describe tipo;
create table if not exists relacion(
id_med varchar (4) not null,
mat_co varchar(8) not null,
id_per varchar(3) not null,
id_piez varchar(3) not null,
precio int (3),
primary key (id_med, mat_co,id_per,id_piez),
foreign key (id_med) references mecanico (id_mec)
on delete 
cascade,
foreign key (mat_co) references coche (mat_co)
on delete 
cascade,
foreign key (id_per) references periodo(id_per)
on delete 
cascade,
foreign key (id_piez) references pieza (id_piez)
on delete
cascade
);
describe relacion ;