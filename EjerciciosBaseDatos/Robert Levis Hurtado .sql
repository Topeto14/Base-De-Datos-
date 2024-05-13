create database profesores;
use profesores;

create table if not exists Instituto(
Cdinsti char(2) primary key,
Nombre varchar(30) not null,
Ciudad varchar (20) not null);

create table if not exists Profesores(
Cdprofe char(3) primary key,
Nombre varchar(30),
Fech_ingreso date,
Cddirector char (3),
Cdinsti char (2),
foreign key (Cddirector) references Profesores (Cdprofe)
on delete set null
on update cascade,
foreign key (Cdinsti) references Instituto(Cdinsti)
on delete restrict 
on update cascade 
);

create table if not exists Proyecto(
Cdpro char(3) primary key,
Nombre varchar (60) not null,
Cdinsti char(2), 
foreign key (Cdinsti) references Instituto (Cdinsti)
on delete restrict
on update cascade 
);

create table if not exists Trabaja (
Cdprofe char(3),  
Cdpro char(3),
Nhoras Integer,
primary key (Cdprofe,Cdpro),
foreign key (Cdprofe) references Profesores (Cdprofe)
on delete cascade 
on update cascade, 
foreign key (Cdpro) references Proyecto (Cdpro)
on delete cascade 
on update cascade
);

Insert into Instituto (Cdinsti,Nombre ,Ciudad)
values    	("01", "IES Jaroso", "Cuevas del Almanzora"),
			("02", "IES El Palmeral","Vera"),
			("03", "IES Alyanub", "Vera"),
			("04", "IES Cura Valera", "Huercal Overa"),
			("05", "IES Albujaira", "Huercal Overa"),
			("06", "IES Cardenal Cisneros", "Albox");
select * from Instituto ;

Insert into Profesores (Cdprofe ,Nombre ,Fech_ingreso ,Cddirector ,Cdinsti)
values  
("A04","EDUARDO ROJO","1997-09-01",NULL,"01"),
("A07","FRANCISCO CARMONA", "1996-09-01",NULL,"02"),
("A11","MARTIN FLORES","2010-09-01",NULL,"05"),
("A14","JUAN ANGEL SOLER","1995-09-01",NULL,"03"),
("A16","PEDRO GARCÍA GARCÍA","1996-09-01",NULL,"06"),
("A01","ANA VICENTE BELMONTE","2022-09-01","A04","01"),
("A02","CATALINA FLORES CAZORLA","2002-09-01","A04","01"),
("A03","JAVIER GUILLEN BENAVENTE","2018-09-01","A04","01"),
("A05","ELOY VILLAR","2006-09-01","A04","01"),
("A06","FRANCISCO MATIAS PRADO","2016-09-01","A04","01"),
("A08","MARI CARMEN SOLER","1996-09-01","A07","02"),
("A09","RICARDO MASIP","1996-10-10","A07","02"),
("A10","ESPERANZA MANZANERA",NULL,"A07","02"),
("A12","FRANCISCA MARTÍNEZDE HARO","2014-09-01","A11","05"),
("A13","MANOLI DIAZ","1995-09-01","A14","03"),
("A15","PABLO FLORES DIAZ","2021-09-01","A11",NULL),
("A17","JESÚS MELLADO GARCÍA","1997-09-01","A16",NULL);

select * from Profesores ;

Insert into Proyecto (Cdpro ,Nombre ,Cdinsti)
values 
		("CAE","CUIDADOS AUXILIARES DE ENFERMERÍA","05"),
		("DAW","DESARROLLO DE APLICACIONES WEBS","01"),
		("GAM","GESTION ADMINISTRATIVA GRADO MEDIO","01"),
		("GAS","GESTION ADMINISTRATIVA GRADO SUPERIOR","03"),
		("SMR","SISTEMAS MICROINFORMÁTICOS Y REDES","04");

select * from Proyecto;

Insert into Trabaja (Cdprofe,Cdpro ,Nhoras)
values 
			("A01","DAW",5),
			("A02","DAW",120),
			("A02","SMR",80),
			("A03","DAW",180),
			("A03","SMR",40),
			("A04","DAW",0),
			("A04","SMR",100),
			("A05","GAM",20),
			("A06","GAS",0),
			("A11","CAE",100),
			("A13","GAM",10),
			("A14","GAS",0),
			("A16","DAW",20);

select * from Trabaja ;


/*Realiza las siguientes consultas. (8puntos).
1. Nombre del profesor o profesores/as que han trabajado más número de horas en
proyectos. La consulta debe mostrar el nombre del profesor y el número de horas.*/

select pf.Nombre,T.Nhoras
from Profesores pf
inner join Trabaja T On pf.Cdprofe = T.Cdprofe
inner join Proyecto py ON py.Cdpro = T.Cdpro
group by pf.Nombre,T.Nhoras
having max(Nhoras) = (select max(Nhoras)
						from Profesores Pf
						inner join Trabaja T On Pf.Cdprofe = T.Cdprofe
                        inner join Proyecto py ON py.Cdpro = T.Cdpro
						group by Pf.Nombre
                        order by 1 desc limit 1);
                        
/*2. Listado de la máxima fecha y mínima fecha de ingreso de los profesores por cada
instituto (en el listado debe de aparecer la máxima fecha, mínima fecha y el nombre
del instituto).*/
/*select pf.Fech_ingreso, I.Nombre
from Profesores pf
inner join Instituto I On pf.Cdinsti = I.Cdinsti
group by pf.Fech_ingreso,I.Nombre 
having max(Fech_ingreso) and min(Fech_ingreso) = (select max(Fech_ingreso) and min(Fech_ingreso)
													from Profesores pf
													inner join Instituto I On pf.Cdinsti = I.Cdinsti
													group by pf.Fech_ingreso,I.Nombre 
                                                    order by max(Fech_ingreso) and min(Fech_ingreso) desc limit 1);
select pf.Fech_ingreso, I.Nombre
from Profesores pf
Inner join Instituto I On pf.Cdinsti= I.Cdinsti 
group by max(pf.Fech_ingreso), min(pf.Fech_ingreso), I.Nombre
having I.Nombre like "IES jaroso";  */

/*3. Nombre de los proyectos en los que trabajan menos de dos profesores.*/

select py.Nombre
from Proyecto py
inner join Trabaja T On py.Cdpro=T.Cdpro
group by py.Nombre
having count(T.Cdpro) = (select count(T.Cdpro)
								from Proyecto py
								inner join Trabaja T On py.Cdpro=T.Cdpro
                                group by py.Nombre
								having count(T.Cdpro) <= 2 
                                order by 1 limit 1); 

/*4. Listado de los nombres de todos los profesores y el nombre del instituto al que
pertenecen, con indicación del dinero total que deben percibir, a razón de 20 euros la
hora de los proyectos en que trabajan.
La lista se presentará ordenada por orden alfabético de nombre del profesor, y en caso
de que no pertenezcan a ningún instituto debe aparecer la palabra “Sin instituto de
Referencia”.*/

select pf.Nombre,I.Nombre,T.Nhoras * 20
from Instituto I
right join Profesores pf On I.Cdinsti = pf.Cdinsti
left join Trabaja T On pf.Cdprofe = T.Cdprofe
order by pf.Nombre, I.Nombre  asc;

/*5. Lista de los nombres de todos los profesores, y el número de proyectos en los que está
trabajando (ten en cuenta que algunos profesores no trabajan en ningún proyecto)
ordenados por número de proyectos de menor a mayor.*/

/*6. Listado de profesores que trabajan en Cuevas del Almanzora o en Huercal Overa.*/

select pr.Nombre 
from Profesores pr
inner join Instituto I On pr.Cdinsti = I.Cdinsti  
where I.Ciudad like "Cuevas del Almanzora" or "Huercal Overa" ;

/*7. Lista alfabética de los nombres de profesores y los nombres de sus directores. Si el
profesor no tiene director debe aparecer la cadena “Es el director”.*/

select pr.Nombre,pr.Cddirector
from Profesores pr
order by pr.Nombre asc ;

/*8. Media del año de ingreso de los profesores que trabajan en algún proyecto.*/

/*9. Nombre de los profesores que tienen de apellido Flores o Guillen, y simultáneamente
su directores es Eduardo Rojo.*/

select Nombre 
from Profesores
where Nombre like "% Guillen" or " % Flores";

/*10. Listado de nombres de todos los instituto, ciudad del instituto y número de profesores
del instituto. Ordenada por nombre de ciudad y a igualdad de esta por el nombre del
instituto.*/

/*11. Lista de nombres de profesor que hayan trabajado entre 20 y 100 horas, entre todos
los proyectos en los que trabajan.
12. Listado de profesores que son directores.
13. Se quiere premiar a los profesores del instituto que mejor productividad tenga. Para
ello se decide que una medida de la productividad puede ser el número de horas
trabajadas por el profesor del instituto en proyectos, dividida por los profesores de ese
instituto.
¿Qué instituto es el más productivo (nombre del instituto)?
14. Listado de todos los profesores, donde aparezcan los nombres de profesores, nombres
de sus institutos y nombres de proyectos en los que trabajan. Los profesores sin
instituto aparecerá “Sin Instituto de referencia”, y los que no trabajen en proyectos
aparecerán “Sin Proyecto”.*/

select pr.Nombre,I.Nombre,py.Nombre
from Profesores pr
right join Instituto I On pr.Cdinsti = I.Cdinsti
left join Proyecto py On py.Cdinsti = I.Cdinsti;

/*15. Lista de todos los profesores indicando el número de días que llevan trabajando en el
Instituto, en el caso de que no tengan fecha de ingreso que aparezca “Sin datos fecha
de ingreso”. Ordenados por nombre de profesor y luego por los días trabajados
16. Lista de los profesores que son directores de más de 2 profesores, junto con el número
de profesores que están a su cargo.*/
/*17. Listar los nombres de proyectos en los que aparezca la palabra “Aplicaciones”,
indicando también el nombre del instituto que */

select Nombre
from Proyecto 
where Nombre like "D%";

/*18. Asignar a la profesora “Catalina Flores Cazorla” al instituto del Profesor Martin Flores.*/
/*19. Borrar los institutos que no tienen profesores.*/
/*delete from Instituto 
where Nombre;*/
/*20. Añadir todos los profesores del instituto 05 al proyecto “GAS”.*/









































