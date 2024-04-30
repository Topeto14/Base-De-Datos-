drop database if exists vendedores;
create database vendedores;
use vendedores;
create table if not exists Ciudad(
id_ciudad char (3) primary key,
nom_ciudad  varchar(15)
);


create table if not exists Tienda(
id_tienda char(3) primary key,
nom_tienda char(15),
id_ciudad char(3),
foreign key (id_ciudad) references Ciudad (id_ciudad)
on delete cascade 
on update cascade 
);


create table if not exists Vendedores (
id_vend char(3) primary key,
nom_vend char(20),
salario double,
id_tienda char(3),
foreign key (id_tienda) references Tienda (id_tienda)
on delete cascade
on update cascade
);


create table if not exists Tipoart(
id_tipo char(3) primary key,
nom_tipo varchar(15)
);


create table if not exists Articulos(
id_art char(3) primary key,
nom_art varchar(15),
precio double,
id_tipo char(3),
foreign key (id_tipo) references Tipoart (id_tipo)
on delete cascade 
on update cascade
);


create table if not exists Vendart(
id_vend char(3),
id_art char(3),
fech_venta date,
primary key (id_vend,id_art,fech_venta),
foreign key (id_art) references Articulos(id_art)
on delete cascade 
on update cascade,
foreign key (id_vend) references Vendedores (id_vend)
on delete cascade 
on update cascade 
);


INSERT INTO Ciudad (id_ciudad, nom_ciudad)
VALUES
    ('CI1', 'SEVILLA'),
    ('CI2', 'ALMERIA'),
    ('CI3', 'GRANADA');
    
SELECT * FROM Ciudad;

INSERT INTO Tienda (id_tienda, nom_tienda, id_ciudad )
VALUES
    ('TD1', 'BAZARES S.A.', 'CI1'),
    ('TD2', 'CADENAS S.A', 'CI1'),
    ('TD3', 'MIRROS S.L.', 'CI2'),
    ('TD4', 'LUNA', 'CI3'),
    ('TD5', 'MAS S.A.', 'CI3'),
    ('TD6', 'JOYMON', 'CI2');
    
SELECT * FROM Tienda;

INSERT INTO Vendedores (id_vend, nom_vend, salario, id_tienda)
VALUES
    ('VN1', 'JUAN', '1090', 'TD1'),
    ('VN2', 'PEPE', '1034', 'TD1'),
    ('VN3', 'LUCAS', '1100', 'TD2'),
    ('VN4', 'ANA', '890', 'TD2'),
    ('VN5', 'PEPA', '678', 'TD3'),
    ('VN6', 'MANUEL', '567', 'TD2'),
    ('VN7', 'LORENA', '1100', 'TD3');

SELECT * FROM Vendedores;

INSERT INTO Tipoart (id_tipo, nom_tipo)
VALUES
    ('TI1', 'BAZAR'),
    ('TI2', 'COMESTIBLES'),
    ('TI3', 'PAPELERIA');

SELECT * FROM Tipoart;

INSERT INTO Articulos (id_art, nom_art, precio,id_tipo)
VALUES
    ('AR1', 'RADIO', 78, 'TI1'),
    ('AR2', 'CARNE', 15, 'TI2'),
    ('AR3', 'BLOC', 5, 'TI3'),
    ('AR4', 'DVD', 24, 'TI1'),
    ('AR5', 'PESCADO', 23, 'TI2'),
    ('AR6', 'LECHE', 2, 'TI2'),
    ('AR7', 'CAMARA', 157, 'TI1'),
    ('AR8', 'LAPIZ', 1, 'TI3'),
    ('AR9', 'BOMBILLA', 2, 'TI1');


SELECT * FROM Articulos;


INSERT INTO Vendart (id_vend,fech_venta, id_art)
VALUES
    ('VN1', '2005-02-01', 'AR1'),
    ('VN1', '2005-02-01', 'AR2'),
    ('VN2', '2005-03-01', 'AR3'),
    ('VN1', '2005-04-01', 'AR4'),
    ('VN1', '2005-06-01', 'AR5'),
    ('VN3', '2005-07-01', 'AR6'),
    ('VN3', '2005-08-01', 'AR7'),
    ('VN3', '2001-09-12', 'AR8'),
    ('VN4', '2005-10-10', 'AR9'),
    ('VN4', '2005-11-01', 'AR8'),
    ('VN5', '2005-10-01', 'AR7'),
    ('VN5', '2005-11-02', 'AR6'),
    ('VN6', '2005-11-03', 'AR5'),
    ('VN6', '2005-11-04', 'AR4'),
    ('VN7', '2005-11-05', 'AR3'),
    ('VN7', '2005-11-07', 'AR2'),
    ('VN1', '2005-11-06', 'AR2'),
    ('VN2', '2004-10-08', 'AR1'),
    ('VN3', '1999-01-01', 'AR2'),
    ('VN4', '2005-10-25', 'AR3'),
    ('VN5', '2005-10-26', 'AR4'),
    ('VN5', '2005-10-27', 'AR5'),
    ('VN6', '2005-10-28', 'AR6'),
    ('VN5', '2005-10-28', 'AR7'),
    ('VN4', '2005-10-30', 'AR8'),
    ('VN3', '2005-08-24', 'AR9'),
    ('VN7', '2005-08-25', 'AR9');
    
select * from Vendart ;
/*1.- CIUDAD DONDE MAS SE VENDIO*/

select c.nom_ciudad
from Ciudad c
JOIN Tienda t ON c.id_ciudad = t.id_ciudad
JOIN Vendedores ve ON t.id_tienda = ve.id_tienda
Join Vendart va ON ve.id_vend = va.id_vend
JOin Articulos a ON va.id_art = a.id_art
GROUP BY c.nom_ciudad
having count(va.id_art) = (select count(va.id_art)
							from Ciudad c
							JOIN Tienda t ON c.id_ciudad = t.id_ciudad
							JOIN Vendedores ve ON t.id_tienda = ve.id_tienda
							Join Vendart va ON ve.id_vend = va.id_vend
							JOin Articulos a ON va.id_art = a.id_art
							GROUP BY c.nom_ciudad
							ORDER BY  count(va.id_art) DESC
							LIMIT 1);


/*2.- TIENDA DONDE MAS SE VENDIO*/

select t.nom_tienda
from Tienda t
inner join Vendedores ve On t.id_tienda = ve.id_tienda
inner join Vendart va On ve.id_vend = va.id_vend
inner join Articulos a ON va.id_art = a.id_art
group by t.nom_tienda
order by sum(a.precio) desc limit 1;

/*3.- VENDEDOR QUE MAS VENDIO*/

select ve.nom_vend
from Vendedores ve
inner join Vendart va On  va.id_vend = ve.id_vend
inner join Articulos a ON va.id_art =a.id_art
group by ve.nom_vend
having count(va.id_art) = (select count(va.id_art)
							from Vendedores ve
							inner join Vendart va On  va.id_vend = ve.id_vend
							inner join Articulos a ON va.id_art =a.id_art
							group by ve.nom_vend
                            order by 1 desc limit 1); /* El numero 1 hace referencia al primer campo del select que esta despues del having, si hubiese mas de uno se elegiria según la posición. */
								
/*4.-NOMBRE DE CIUDAD, VENDEDOR, ARTICULO, TIENDA TIPO Y PRECIO DE TODO LO VENDIDO*/

select c.nom_ciudad, ve.nom_vend, a.nom_art,t.nom_tienda,ta.nom_tipo,a.precio
from Articulos a
inner join Tipoart ta ON a.id_tipo = ta.id_tipo
inner join Vendart va ON a.id_art = va.id_art
inner join Vendedores ve ON va.id_vend = ve.id_vend
inner join Tienda t ON ve.id_tienda = t.id_tienda
inner join Ciudad c ON t.id_ciudad = c.id_ciudad;


/*5.- NOMBRE DEL TIPO DE ARTICULO MAS CARO*/

select t.nom_tipo
from Tipoart t
inner join Articulos a ON t.id_tipo = a.id_tipo
where a.precio = (select max(precio)
							from Articulos);
                            



/*6.- DATOS DEL VENDEDOR QUE MAS GANA*/
select id_vend,nom_vend,salario
from vendedores
where salario = (select max(salario)
				from Vendedores);


/*7.- MONTANTE DE TODOS LOS ARTICULOS DE TIPO BAZAR*/

select sum(a.precio)
from Articulos a
inner join Tipoart ta ON a.id_tipo = ta.id_tipo
inner join Vendart va ON a.id_art = va.id_art
where ta.nom_tipo like "BAZAR";

/*8.- MONTANTE DE TODO LO QUE SE VENDIO EN ALMERIA*/

select sum(a.precio)
from Articulos a
inner join Vendart va ON a.id_art = va.id_art
inner join Vendedores ve ON va.id_vend = ve.id_vend
inner join Tienda t ON ve.id_tienda = t.id_tienda
inner join Ciudad c ON t.id_ciudad = c.id_ciudad
where c.nom_ciudad like "ALMERIA";
 
/*9.- MONTANTE DE TODO LO QUE SE VENDIO EN LUNA*/

select precio 
from Articulos a
inner join Vendart va ON a.id_art = va.id_art
inner join Vendedores ve ON va.id_vend = ve.id_vend
inner join Tienda t ON ve.id_tienda = t.id_tienda
group by precio
having sum(a.precio) = (select sum(a.precio)
								from Articulos a
								inner join Vendart va ON a.id_art = va.id_art
								inner join Vendedores ve ON va.id_vend = ve.id_vend
								inner join Tienda t ON ve.id_tienda = t.id_tienda
								where t.nom_tienda like "LUNA");


select sum(a.precio)
from Articulos a
inner join Vendart va ON a.id_art = va.id_art
inner join Vendedores ve ON va.id_vend = ve.id_vend
inner join Tienda t ON ve.id_tienda = t.id_tienda
where t.nom_tienda like "LUNA";

/*10.- NOMBRE DE ARTICULO, TIPO PRECIO, TIENDA, CIUDAD Y FECHA DE LO QUE VENDIO MANUEL*/

select a.nom_art, ta.nom_tipo, a.precio,t.nom_tienda,c.nom_ciudad,va.fech_venta,ve.nom_vend
from Tipoart ta
inner join Articulos a ON ta.id_tipo = a.id_tipo
inner join Vendart va ON a.id_art = va.id_art
inner join Vendedores ve ON va.id_vend = ve.id_vend
inner join Tienda t ON ve.id_tienda = t.id_tienda 
inner join Ciudad c ON t.id_ciudad = c.id_ciudad
where ve.nom_vend like "Manuel";

/*11.- TOTAL DEL SALARIO DE TODOS LOS TRABAJADORES DFE ALMERIA*/

select sum(ve.salario)
from Vendedores ve 
inner join Tienda t On ve.id_tienda = t.id_tienda
inner join Ciudad c ON t.id_ciudad = c.id_ciudad
where c.nom_ciudad like "Almeria";

/*12.- NOMBRE DE LOS QUE VENDIERON LECHE*/
select v.nom_vend
from Vendedores v
inner join Vendart va On v.id_vend = va.id_vend
inner join Articulos a On va.id_art = a.id_art 
where a.nom_art like "leche";

/*13.- NOMBRE DE LOS QUE VENDIERON ARTICULOS DE TIPO BAZAR.*/

select distinct v.nom_vend
from Vendedores v
inner join Vendart va On v.id_vend = va.id_vend
inner join Articulos a On va.id_art = a.id_art 
inner join Tipoart ta On a.id_tipo = ta.id_tipo
where ta.nom_tipo like "Bazar";

/*14.- ARTICULOS DE TIPO BAZAR MAS VENDIDOS*/
/*SELECT A.nom_art, COUNT(*) AS cantidad_vendida
FROM Articulos A
INNER JOIN Vendart VA ON A.id_art = VA.id_art
INNER JOIN Tipoart T ON A.id_tipo = T.id_tipo
WHERE T.nom_tipo = 'BAZAR'
GROUP BY A.nom_art
having count(VA.id_art) = (select count(VA.id_art) 
					FROM Articulos A
					INNER JOIN Vendart VA ON A.id_art = VA.id_art
					INNER JOIN Tipoart T ON A.id_tipo = T.id_tipo
					WHERE T.nom_tipo = 'BAZAR'
                    group by A.nom_art
                    order by 1 desc limit 1);
                    
/*15.- NOMBRE DEL TIPO CON QUE MAS SE GANA*/

SELECT T.nom_tipo
FROM Tipoart T
INNER JOIN Articulos A ON T.id_tipo = A.id_tipo
INNER JOIN Vendart VA ON A.id_art = VA.id_art
GROUP BY T.nom_tipo
ORDER BY SUM(A.precio) DESC
LIMIT 1;

/*16.- SALARIO Y NOMBRE DE TODOS LOS QUE VENDIERON BOMBILLAS.*/

SELECT V.nom_vend, V.salario
FROM Vendedores V
INNER JOIN Vendart VA ON V.id_vend = VA.id_vend
INNER JOIN Articulos A ON VA.id_art = A.id_art
WHERE A.nom_art = 'BOMBILLA';

/*17.- TIENDAS Y CIUDAD DONDE SE VENDIO ALGUNA RADIO.*/

SELECT distinct T.nom_tienda, C.nom_ciudad
FROM Ciudad C
INNER JOIN Tienda T ON T.id_ciudad = T.id_ciudad
INNER JOIN Vendedores V On T.id_tienda = V.id_tienda
INNER JOIN Vendart VA ON V.id_vend = VA.id_vend
INNER JOIN Articulos A ON VA.id_art = A.id_art
WHERE A.nom_art = 'RADIO';

/*18.- SUBIR EL SUELDO UN 2% A LOS EMPLEADOS DE SEVILLA*/

UPDATE Vendedores V SET salario = salario * 1.02
WHERE V.id_tienda IN (SELECT id_tienda FROM Tienda T inner join Ciudad C On T.id_ciudad =C.id_ciudad where C.nom_ciudad like "Sevilla");
select * from Vendedores ;

/*19.- BAJA EL SUELDO UN 1% A LOS QUE NO HAYAN VENDIDO LECHE*/
SET SQL_SAFE_UPDATES=0;
UPDATE Vendedores V SET salario = salario * 0.99
WHERE V.id_vend not in (SELECT DISTINCT VA.id_vend
										FROM Vendart VA
										INNER JOIN Articulos A ON VA.id_art = A.id_art
										WHERE A.nom_art = 'LECHE');
select * from Vendedores ;               
                         
/*20.- SUBIR EL PRECIO UN 3% AL ARTICULO MAS VENDIDO*/

Update Articulos  SET precio = precio * 1.03
where id_art IN (select id_art 
							from Vendart 
							group by id_art
                            having count(id_art) = (select count(id_art)
														from Vendart 
														group by id_art
                                                        order by 1 desc 
                                                        limit 1));
      
select * from Articulos;                            

/*21.- SUBIR EL Precio UN 2% A LOS ARTICULOS DE TIPO MAS VENDIDO*/
create view subirprecios as (select A.id_tipo 
							From Articulos A
                            inner join Vendart Va on  A.id_art = Va.id_art
                            group by A.id_tipo
                            having count(Va.id_art) = (select count(Va.id_art)
															from Vendart Va
                                                            inner join Articulos A On Va.id_art = A.id_art
                                                            group by A.id_tipo
                                                            order by 1 desc limit 1));
Update Articulos SET precio = precio * 1.02
where id_tipo In (select id_tipo 
						from subirprecios);

select * from subirprecios;
select * from Articulos;








UPDATE Articulos SET precio = precio * 1.02
where id_art In (select id_art 
						from Vendart 
                        group by id_art
                        having count(id_art) = (select count(id_art)
													from Vendart 
                                                    group by id_art
                                                    order by 1 desc
                                                    limit 1));

select * from Vendedores; 

/*22.- BAJAR UN 3% TODOS LOS ARTICULOS DE PAPELERIA*/

UPDATE Articulos SET precio = precio * 0.97
WHERE id_tipo = (SELECT id_tipo FROM Tipoart WHERE nom_tipo = 'PAPELERIA');
select * from Articulos ;

/*23.- SUBIR EL PRECIO UN 1% A TODOS LOS ARTICULOS VENDIDOS EN ALMERIA*/
UPDATE Articulos SET precio = precio * 1.01
WHERE id_art IN (SELECT id_art
						FROM Vendart
						WHERE id_vend IN (SELECT id_vend 
												FROM Tienda 
                                                WHERE id_tienda IN (select id_tienda
																			from Tienda 
                                                                            where id_ciudad In (select id_ciudad
																									from Ciudad
                                                                                                    where nom_ciudad like "Almeria"))));
select * from Articulos ;                                                                                                    
/*24.- BAJAR EL PRECIO UN 5% AL ARTICULO QUE MAS HACE QUE NO SE VENDE*/

UPDATE Articulos SET precio = precio * 0.95
WHERE id_art = (SELECT id_art
						FROM Vendart
						WHERE fech_venta = (SELECT  min(fech_venta) 
														FROM Vendart));
select * from Articulos ;
                                            
/*25.- CERRAR LA TIENDA QUE MENOS HA VENDIDO*/
DELETE FROM Tienda
WHERE id_tienda = (
    SELECT id_tienda
    FROM Tienda T
    LEFT JOIN Vendedores V ON T.id_tienda = V.id_tienda
    inner join Vendart Va ON V.id_vend = Va.id_vend
    GROUP BY V.id_tienda
    having COUNT(Va.id_art) = (select count(Va2.id_art)
											From Vendart Va2
                                            LEFT JOIN Vendedores V ON Va2.id_vend = V2.id_vend
                                            group by V2.id_tienda
                                            order by count(Va2.id_art)
                                            asc limit 1));
 select * from Tienda;    
 
 create view cerrartiendas4 as (SELECT T.id_tienda
										FROM Tienda T
										LEFT JOIN Vendedores V ON T.id_tienda = V.id_tienda
										inner join Vendart Va ON V.id_vend = Va.id_vend
										GROUP BY T.id_tienda
										having COUNT(Va.id_art) = (select count(Va2.id_art)
																				From Vendart Va2
                                                                                LEFT JOIN Vendedores V2 ON Va2.id_vend = V2.id_vend
																				group by V2.id_tienda
																				order by count(Va2.id_art)
																				asc limit 1));
                                                                                
select * from cerrartiendas4;                                                                                
					                   
                    
/*26.- LA TIENDA LUNA PASA A LLAMARSE SOL Y LUNA*/
UPDATE Tienda
SET nom_tienda = 'SOL Y LUNA'
WHERE nom_tienda = 'LUNA';
select * from Tienda ; 
/*27.- DESPEDIR AL TRABAJADOR QUE MAS VENDIO*/
DELETE FROM Vendedores
WHERE id_vend = (SELECT id_vend
						FROM Vendart
						GROUP BY id_vend
						having COUNT(id_art) = (select count(id_art)
															from Vendart
															group by id_vend
															order by 1 desc limit 1));
/*Creando una vista */
  create view despedir2 as (SELECT id_vend
									FROM Vendart
									GROUP BY id_vend
									having COUNT(id_art) = (select count(id_art)
																		from Vendart
																		group by id_vend
																		order by 1 desc limit 1));
select * from despedir2 ;   
      
                                                              
/*28.- LAS TIENDAS QUE NO VENDIERON LAPICES PASAN TODAS A SEVILLA*/

UPDATE Tienda SET id_ciudad = (select id_ciudad
										from ciudad
										where nom_ciudad like 'Sevilla')
																WHERE id_tienda NOT IN (SELECT DISTINCT VA.id_tienda
																										FROM Vendart VA
																										inner join Vendedores V On Va.id_vend = V.id_vend
																										INNER JOIN Articulos A ON VA.id_art = A.id_art
																										WHERE A.nom_art = 'LAPIZ');
/*Como lo hace la profesora */
update tienda set id_ciudad=(select id_ciudad
							from ciudad
                            where nom_ciudad like 'Sevilla')
													where id_tienda not in(select distinct id_tienda
																			from vendart,vendedores,articulos
																			where vendart.id_vend=vendedores.id_vend
																			and vendart.id_art=articulos.id_art
																			and nom_art like 'Lapiz');   
/*Crear vista */                        
create view nolapiz as (select id_ciudad
							from ciudad
                            where nom_ciudad like 'Sevilla') 
													where id_tienda not in(select distinct id_tienda
													from vendart,vendedores,articulos
													where vendart.id_vend=vendedores.id_vend
													and vendart.id_art=articulos.id_art
													and nom_art like 'Lapiz');                       
    
/*29.- DESPEDIR AL QUE MENOS DINERO HA HECHO VENDIENDO.*/
select id_vend 
from vendart,articulos
where vendart.id_art=articulos.id_art
group by id_vend
having sum(precio)=(select sum(precio)
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_vend
                order by 1 limit 1);


delete from vendedores
where id_vend in (select id_vend 
					from vendart,articulos
					where vendart.id_art=articulos.id_art
					group by id_vend
					having sum(precio)=(select sum(precio)
										from vendart,articulos
										where vendart.id_art=articulos.id_art
										group by id_vend
										order by 1 limit 1));
/* pendiente hacerla con una vista*/
                
                
select * from vendedores;

/*30.- EL ARTICULO QUE MENOS SE HA VENDIDO DEJAR DE ESTAR EN STOCK*/

select id_art, count(*)
from vendart
group by id_art
having count(*)=(select count(*)
				from vendart
				group by id_art
				order by 1 limit 1);

select * from vendart;

delete from articulos
where id_art in (select id_art
						from vendart
						group by id_art
						having count(*)=(select count(*)
												from vendart
												group by id_art
												order by 1 limit 1));
                                                
/*31.- EL ARTICULO QUE MENOS DINERO HA GENERADO DEJA DE ESTAR EN STOCK*/

create view articulosstock as 
select vendart.id_art
from vendart,articulos
where vendart.id_art=articulos.id_art
group by vendart.id_art
having sum(precio)=(select sum(precio)
					from vendart,articulos
                    where vendart.id_art=articulos.id_art
					group by vendart.id_art
                    order by 1 limit 1);
                    
select * from articulosstock;
                    
                    
delete from articulos
where id_art in (select id_art
				from articulosstock);



                    
                    
select * from articulosstock;
   /* sin vista*/
   
delete from articulos
where id_art in( select vendart.id_art
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by vendart.id_art
				having sum(precio)=(select sum(precio)
									from vendart,articulos
									where vendart.id_art=articulos.id_art
									group by vendart.id_art
									order by 1 limit 1));  

/*32.- EL TIPO DE ARTICULO MENOS VENDIDO DEJA DE ESTAR EN STOCK*/

delete from tipoart
where id_tipo in (select id_tipo
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_tipo
				having count(*)=(select count(*)
								from vendart,articulos
								where vendart.id_art=articulos.id_art
								group by id_tipo
								order by 1 limit 1));
                
                
//*CREADO VISTA*/
CREATE VIEW ARTICULOMENOSVENDIDO AS
select id_tipo
from vendart,articulos
where vendart.id_art=articulos.id_art
group by id_tipo
having count(*)=(select count(*)
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_tipo
                order by 1 limit 1);


DELETE FROM ARTICULOS 
WHERE id_tipo in (select id_tipo from articulomenosvendido);
/*33.- EL TIPO DE ARTICULO CON EL QUE MENOS SE HA GANADO DEJA DE ESTAR EN STOCK*/

create view  tipostock as
select id_tipo
from vendart,articulos
where vendart.id_art=articulos.id_art
group by id_tipo
having sum(precio)=(select sum(precio)
				from vendart,articulos
				where vendart.id_art=articulos.id_art
				group by id_tipo
                order by 1 limit 1);
                
delete from tipoart
where id_tipo in (select id_tipo from tipostock);
/*sin vista*/
delete from tipoart
where id_tipo in(select id_tipo
					from vendart,articulos
					where vendart.id_art=articulos.id_art
					group by id_tipo
					having sum(precio)=(select sum(precio)
									from vendart,articulos
									where vendart.id_art=articulos.id_art
									group by id_tipo
									order by 1 limit 1));
/*34.- SE DESPIDEN A TODOS LOS TRABAJADORES QUE NO HAN VENDIDO ARTICULOS DE BAZAR*/
DELETE FROM Vendedores
WHERE id_vend NOT IN (
    SELECT DISTINCT VA.id_vend
    FROM Vendart VA
    INNER JOIN Articulos A ON VA.id_art = A.id_art
    INNER JOIN Tipoart T ON A.id_tipo = T.id_tipo
    WHERE T.nom_tipo = 'BAZAR'
);
delete from vendedores
where id_vend not in (select id_vend
					from vendart,articulos,tipoart
					where vendart.id_art=articulos.id_art
					and articulos.id_tipo=tipoart.id_tipo
					and nom_tipo like 'Bazar');


select id_vend
from vendart,articulos,tipoart
where vendart.id_art=articulos.id_art
and articulos.id_tipo=tipoart.id_tipo
and nom_tipo like 'Bazar';
/*35.- SE CIERRA LA TIENDA QUE MENOS DINERO HA GANADO.*/

delete from tienda
where id_tienda in (select id_tienda
				from vendart,vendedores,articulos
				where vendart.id_vend=vendedores.id_vend
			and vendart.id_art=articulos.id_art
			group by id_tienda
			having sum(precio)=(select sum(precio)
								from vendart,vendedores,articulos
								where vendart.id_vend=vendedores.id_vend
								and vendart.id_art=articulos.id_art
								group by id_tienda
								order by 1 limit 1));

/*averiguo la tienda que menos ha vendido*/
select id_tienda
from vendart,vendedores,articulos
where vendart.id_vend=vendedores.id_vend
and vendart.id_art=articulos.id_art
group by id_tienda
 having sum(precio)=(select sum(precio)
					from vendart,vendedores,articulos
					where vendart.id_vend=vendedores.id_vend
					and vendart.id_art=articulos.id_art
					group by id_tienda
					order by 1 limit 1);
/*36.- TODOS LOS TRABAJADORES DE SEVILLA PASAN A LA TIENDA JOYMON*/

update vendedores set id_tienda=(select 
								id_tienda from tienda
                                where nom_tienda like 
								'Joymon')
where id_tienda in (select id_tienda
					from ciudad, tienda
					where ciudad.id_ciudad=tienda.id_ciudad
					and  nom_ciudad like 'Sevilla');

