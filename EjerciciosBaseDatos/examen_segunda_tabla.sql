create database if not exists Examen1;
use Examen1;

Create table if not exists Cliente (
id_cli char(3) primary key,
nom_cli varchar(25),
telf_cli varchar(9)
);
Describe Cliente;

Create table if not exists Alojamientos (
id_aloj char(3) primary key,
nom_aloj varchar(25),
habitaciones int,
categoria varchar(5)
);
Describe Alojamientos;

create table if not exists Empleado (
id_emp char(3) primary key,
nom_emp varchar(25),
sueldo double,
id_aloj char(3),
foreign key (id_aloj) references Alojamientos (id_aloj)
on delete cascade
on update cascade
);
Describe Empleado;

create table if not exists Cli_aloj(
id_cli char(3),
id_aloj char(3),
fech_entrada date,
fech_salida date,
precio double,
foreign key (id_cli) references Cliente (id_cli)
on delete cascade
on update cascade,
foreign key(id_aloj) references Alojamientos(id_aloj)
on delete cascade
on update cascade,
primary key (id_cli,id_aloj,fech_entrada)
);
Describe Cli_aloj;