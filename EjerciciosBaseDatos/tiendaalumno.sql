DROP database IF EXISTS tiendaalumno;
CREATE database if not exists tiendaalumno;
use tiendaalumno;
Create table if not exists clientes(
	id_cliente int (4) not null auto_increment primary key,
    nombre varchar(75),
    direccion varchar(100),
    telefono varchar (12),
    ciudad varchar (30)
);
create table if not exists productos(
	id_producto  char(4) primary key,
    descripcion varchar(30),
    precio float(6)
);
describe productos;
create table if not exists venta(
	id_venta int (4) auto_increment not null primary key,
    cantidad int (6),
    id_producto char(4),
    id_cliente int(4) not null,
    foreign key (id_producto) references productos (id_producto)
    on delete restrict
    on update cascade,
    foreign key (id_cliente) references clientes (id_cliente)
    on delete restrict
    on update cascade
);
describe venta ;