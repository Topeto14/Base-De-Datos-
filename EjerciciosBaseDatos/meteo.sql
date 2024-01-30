drop database if exists meteo ;
create database if not exists meteo;
use meteo ;
create table if not exists estacion(
	id int auto_increment primary key,
    latitud varchar(6),
    longitud varchar(6),
    altitud varchar(6)
);
describe estacion ;
create table if not exists muestra(
	id_estacion int ,
    fecha date,
    temperatura_minima varchar(3),
    temperatura_maxima varchar(3),
    precipitaciones varchar(4),
    humedad_minima varchar(3),
    humedad_maxima varchar(3),
    velocidad_viento_minimo varchar(3),
    velocidad_viento_maximo varchar(3),
    primary key (id_estacion, fecha),
    foreign key (id_estacion) references estacion(id)
    on delete cascade
    on update cascade
);
describe muestra;