CREATE DATABASE IF NOT EXISTS relacion_1;
USE relacion_1;
CREATE TABLE if not exists alumnos(
id_al CHAR(3) primary key,
nom_al VARCHAR(40),
fech_al DATE,
telf_al VARCHAR(9)
);
DESCRIBE alumnos;
CREATE TABLE IF NOT EXISTS profesores(
id_prof CHAR(3) primary key,
nom_prof VARCHAR(40),
fech_prof date,
telf_prof VARCHAR(9)
);
DESCRIBE profesores;
CREATE TABLE IF NOT EXISTS relaciones(
id_al CHAR(3),
id_prof CHAR(3),
nota DOUBLE,
primary key(id_al,id_prof),
foreign KEY (id_al) REFERENCES alumnos(id_al)
on delete cascade
on update cascade,
Foreign key (id_prof) REFERENCES profesores(id_prof)
on delete cascade
on update cascade
);
describe relaciones;
