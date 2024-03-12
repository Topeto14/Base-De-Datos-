Use Examen1;
insert into Cliente (id_cli, nom_cli, telf_cli)
values 	("C01", "JUAN FERNÁNDEZ", "898765678"),
		("C02", "ANA GARCÍA", "678987567"),
        ("C03", "PEPA FLORES", "432123456"),
		("C04", "JOSÉ LINARES", "950122145"),
		("C05", "LUIS JARCIA", "954678763"),
		("C06", "XAVI PÉREZ", "900873221"),
		("C07", "LUISA JUANES", "878909876"),
		("C08", "HILARIO PINO", "675121234"),
		("C09", "CARMEN CONSUEGRA", "123234789"),
		("C10", "VICENTA FERRER", "924866378"),
		("C11", "OLIVIA GINESA", "789123456"),
		("C12", "JUANJO DÍAZ", "911234321");

select * from Cliente;

insert into Alojamientos(id_aloj, nom_aloj, habitaciones, categoria)
values  ("A01", "TERRAZA CARMONA", "100", "***"),
		("A02", "VALLE DEL ESTE", "250", "****"),
		("A03", "HOSTAL LUCERO", "17", "**"),
		("A04", "VERA PLAYA", "350", "****"),
		("A05", "HOTEL MEXICO", "80", "****");
select * from Alojamientos;

insert into Empleado (id_emp, nom_emp, sueldo, id_aloj)
values 	("E01", "MANUEL MURCIA", 1400, "A01"),
		("E02", "GINÉS ASENSIO FERNÁNDEZ", 1500, "A01"),
		("E03", "BALTASAR PARRA GIMÉNEZ", 950, "A02"),
		("E04", "ROSA PÉREZ GARCÍA", 1300, "A03"),
		("E05", "JOSÉ MIGUEL MARTÍNEZ CANO", 1150, "A04"),
		("E06", "ANTONIO FERNÁNDEZ SOTO", 1200, "A05"),
		("E07", "ANA GARCÍA GIMÉNEZ", 1100, "A04"),
		("E08", "MARÍA CAPARROS GÓMEZ", 1300, "A04"),
		("E09", "ALICIA FLORES DÍAZ", 1500, "A05");
select * from Empleado;    

insert into Cli_aloj (id_cli, id_aloj, fech_entrada, fech_salida, precio)
values	 	("C01", "A01", "2013/03/01", "2013/03/10", 345),
			("C02", "A01", "2013/04/01", "2013/04/02", 60),
			("C03", "A01", "2013/03/02", "2013/03/11", 540),
			("C04", "A02", "2013/04/03", "2013/04/10", 420),
			("C05", "A02", "2013/05/04", "2013/05/10", 395),
			("C06", "A02", "2013/06/05", "2013/06/10", 145),
			("C07", "A02", "2013/07/06", "2013/07/10", 450),
			("C08", "A03", "2013/08/07", "2013/08/10", 344),
			("C09", "A03", "2013/08/08", "2013/08/10", 349),
			("C10", "A03", "2013/10/09", "2013/10/10", 145),
			("C11", "A03", "2013/11/11", "2013/11/15", 245),
			("C12", "A03", "2013/12/21", "2013/12/30", 600),
			("C01", "A04", "2013/09/05", "2013/09/07", 148),
			("C02", "A03", "2013/10/07", "2013/10/14", 849),
			("C03", "A03", "2013/03/11", "2013/03/15", 248),
			("C04", "A03", "2013/03/21", "2013/03/30", 345),
			("C05", "A01", "2013/03/11", "2013/03/19", 149),
			("C06", "A02", "2013/06/21", "2013/06/30", 315),
			("C01", "A01", "2013/01/11", "2013/01/20", 319),
			("C03", "A04", "2014/02/14", "2014/02/16", 200),
			("C04", "A05", "2014/02/14", "2014/02/16", 300),
			("C09", "A05", "2014/03/07", "2014/03/09", 400);

select * from Cli_aloj;

/*- REALIZA LAS SIGUIENTES CONSULTAS:
Cada consulta 0.5 punto. Total consultas 7.5 puntos.*/
/*1. Nombre de los alojamientos de cuatro estrellas que tienen mayor número de 
habitaciones.*/
select nom_aloj
from alojamientos
where categoria = "****"
order by habitaciones desc;
/*2. Datos de los empleados cuyo sueldo está comprendido entre 900 y 1200 euros
ordenados de mayor a menor sueldo.*/
select * from empleado 
where sueldo between 900 and 1200
order by sueldo desc;  
/*3. Datos de los empleados cuyo sueldo es mayor que la media de todos los 
empleados.*/
select * from empleado 
where sueldo > (select avg (sueldo)
from empleado);
/*4. Nombre de los clientes que se han hospedado en el Alojamiento Vera Playa.*/
SELECT DISTINCT c.nom_cli
FROM Cliente c
JOIN Cli_aloj ca ON c.id_cli = ca.id_cli
JOIN Alojamientos a ON ca.id_aloj = a.id_aloj
WHERE a.nom_aloj = 'Vera Playa';
/*5. Nombres de los clientes y dinero total que se han gastado en alojarse.*/
SELECT c.nom_cli, SUM(ca.precio) AS total_gastado
FROM Cliente c
JOIN Cli_aloj ca ON c.id_cli = ca.id_cli
GROUP BY c.nom_cli;
/*6. Nombre de los alojamientos y fechas en los que ha estado hospedado el cliente 
XAVI PÉREZ, ordenado por el nombre del hotel.*/
select a.nom_aloj, ca.fech_entrada, ca.fech_salida
from Alojamientos a
join Cli_aloj ca on a.id_aloj = ca.id_aloj
join Cliente c on c.id_cli = ca.id_cli
where c.nom_cli = "XAVI PÉREZ" 
order by a.nom_aloj;
/*7. Datos del cliente/s que más establecimientos ha visitado.*/
select c.nom_cli, count(distinct ca.id_aloj) as num_alojamientos
from Cliente c
join Cli_aloj ca on c.id_cli = ca.id_cli
group by c.nom_cli
order by num_alojamientos desc limit 1;
/*8. Listado de alojamientos, donde aparezca el nombre de cada alojamiento y el 
dinero que ha ganado en los hospedajes ordenados por nombre del alojamiento.*/
select a.nom_aloj, SUM(ca.precio) as dinero_ganado
from Alojamientos a
join Cli_aloj ca on a.id_aloj = ca.id_aloj 
group by a.nom_aloj
order by a.nom_aloj;
/*9. El nombre del empleado y nombre del alojamiento en que trabaja el empleado 
que menor sueldo tiene.*/
select e.nom_emp, a.nom_aloj
from Empleado e
join Alojamientos a on e.id_aloj = a.id_aloj
order by e.sueldo asc limit 1;
/*10. Nombre del alojamiento o alojamientos con mayor número de empleados.*/
SELECT a.nom_aloj, COUNT(e.id_emp) AS num_empleados
FROM Alojamientos a
JOIN Empleado e ON a.id_aloj = e.id_aloj
GROUP BY a.nom_aloj
ORDER BY num_empleados DESC
LIMIT 1;
/*11. Listado que contenga la media del sueldo de los empleados por cada 
alojamiento. Donde aparezca la media del sueldo y el nombre del alojamiento.*/
select a.nom_aloj, avg(e.sueldo) as media_sueldo
from Alojamientos a 
join Empleado e On a.id_aloj = e.id_aloj
group by a.nom_aloj
/*12. El sueldo de los empleados que trabajan en el alojamiento HOSTAL LUCERO 
se incrementa en un 20% (es decir se actualiza la tabla empleados).*/
UPDATE Empleado
SET sueldo = sueldo * 1.20
WHERE id_aloj = (SELECT id_aloj FROM Alojamientos WHERE nom_aloj = 'HOSTAL LUCERO');
/*13. El alojamiento Terraza Carmona reduce el número de habitaciones a 75.*/
UPDATE Alojamientos
SET habitaciones = 75
WHERE nom_aloj = 'Terraza Carmona';
/*14. Añade un nuevo empleado con los datos que tu quieras menos el sueldo que 
será la media de todos empleados que ya tenemos y el número de empleado que 
será ‘E10’.*/
INSERT INTO Empleado (id_emp, nom_emp, sueldo, id_aloj)
VALUES ('E10', 'NombreEmpleado', (SELECT AVG(sueldo) FROM Empleado), 'id_Aloj');
/*15. Borra los empleados que trabajen en Terraza Carmona*/
DELETE FROM Empleado
WHERE id_aloj = (SELECT id_aloj FROM Alojamientos WHERE nom_aloj = 'Terraza Carmona');