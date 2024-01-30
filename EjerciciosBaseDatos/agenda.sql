CREATE DATABASE IF NOT EXISTS agenda ;
use agenda;
CREATE table if not exists personas(
	id INT auto_increment primary key,
	nombre VARCHAR(40),
	fecha date
);

create table if not exists telefonos3(
	numero CHAR(12),
    id int not null,
    primary key (id),
    foreign key(id) references personas(id)
    on delete cascade
    on update cascade
);
drop database if exists agenda; /*borra la bd agenda*/