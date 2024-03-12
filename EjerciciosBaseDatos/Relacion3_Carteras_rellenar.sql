USE Carteros;
INSERT INTO Provincia (Id_prov, Nom_prov)
Values 	("P01", "SEVILLA"),
		("P02", "GRANADA"),
        ("P03", "ALMERIA");
SELECT * FROM Provincia ;
INSERT INTO Ciudad (Id_ciud, Nom_ciud, Num_hab, Id_prov)
Values 	    ("C01", "CIUDAD1", 890000, "P01"),
			("C02", "CIUDAD2", 110000, "P02"),
            ("C03", "CIUDAD3", 98000, "P03"), 
            ("C04", "CIUDAD4", 65000, "P01");
SELECT * FROM Ciudad;
INSERT INTO Cartero (Id_cart, Nom_cart, Sueldo)
Values		("CT1", "JUAN PEREZ", 1100),
			("CT2", "ANA TORRES", 1080),
			("CT3", "PEPA FERNANDEZ", 1100),
			("CT4", "VICENTE VALLES", 1790),
			("CT5", "FERNANDO GINES", 1013),
			("CT6", "LISA TORMES", 897),
			("CT7", "WALDO PEREZ", 899),
			("CT8", "KIKA GARCIA", 987),
			("CT9", "LOLA JIMENEZ", 1123);
SELECT * FROM Cartero ;
INSERT INTO Periodos (Id_per, fecha_ini, fecha_fin)
VALUES 	("PE1", "2000/05/01", "2000/03/30"),			
		("PE2", "2000/03/30", "2000/08/15"),
		("PE3", "2000/08/15", "2000/11/20"),
		("PE4", "2000/11/20", "2000/12/25"),
		("PE5", "2000/12/25", "2001/03/03");
SELECT * FROM Periodos ;
INSERT INTO Zona (Id_zona, Nom_zona, Id_Ciud)
VALUES  ("Z01", "CENTRO", "C01"),
		("Z02", "ESTE", "C01"), 
		("Z03", "OESTE", "C01"), 
		("Z04", "NORTE", "C01"),
		("Z05", "SUR", "C01"),
		("Z01", "CENTRO", "C02"),
		("Z02", "POLIOGONO", "C02"),
        ("Z03", "OESTE", "C02"),
        ("Z04", "NORTE", "C02"),
		("Z05", "SUR", "C02"),
		("Z01", "CENTRO", "C03"),
		("Z02", "ESTE", "C03"),
		("Z03", "BARRIADAS", "C03"),
		("Z04", "NORTE", "C03"), 
		("Z05", "SUR", "C03"),
		("Z01", "CENTRO", "C04"),
		("Z02", "BULEVARD", "C04"),
		("Z03", "OESTE", "C04"),
		("Z04", "NORTE", "C04"),
		("Z05", "RIVERA", "C04");
SELECT * FROM Zona ;
INSERT INTO Relacion2 (Id_zona, Id_ciud, Id_cart, Id_per)
VALUES 	("Z01", "C01", "CT1", "PE1"),
		("Z01", "C02", "CT2", "PE1"),
		("Z01", "C03", "CT3", "PE1"),
		("Z01", "C04", "CT4", "PE1"),
		("Z02", "C01", "CT5", "PE1"),
		("Z02", "C02", "CT6", "PE1"),
		("Z02", "C03", "CT7", "PE1"),
		("Z02", "C04", "CT8", "PE1"),
		("Z03", "C01", "CT9", "PE1"),
		("Z03", "C02", "CT1", "PE2"),
		("Z03", "C03", "CT2", "PE2"),
		("Z03", "C04", "CT3", "PE2"),
		("Z04", "C01", "CT4", "PE2"),
		("Z04", "C02", "CT5", "PE2"),
		("Z04", "C03", "CT6", "PE2"),
		("Z04", "C04", "CT7", "PE2"),
		("Z05", "C01", "CT8", "PE2"),
		("Z05", "C02", "CT9", "PE2"),
		("Z05", "C03", "CT1", "PE3"),
		("Z05", "C04", "CT2", "PE3"),
		("Z01", "C01", "CT3", "PE3"),
		("Z02", "C02", "CT4", "PE3"),
		("Z03", "C01", "CT5", "PE3"),
		("Z04", "C01", "CT6", "PE3"),
		("Z05", "C01", "CT7", "PE3"),
		("Z01", "C01", "CT8", "PE4"),
		("Z02", "C03", "CT9", "PE3"),
		("Z03", "C04", "CT1", "PE4"),
		("Z04", "C01", "CT2", "PE4"),
		("Z05", "C01", "CT3", "PE4");
SELECT * FROM Relacion2 ;
/*1.-NOMBRE DE CIUDAD CON MÁS HABITANTES.*/
SELECT nom_ciud
FROM ciudad
WHERE Num_hab = (SELECT max(Num_hab) FROM ciudad);
/*2.- NOMBRE DEL CARTERO CON MAYOR SUELDO*/
SELECT nom_cart 
FROM cartero
WHERE sueldo = (SELECT max(sueldo) FROM cartero);
/*3.- NOMBRE CIUDADES, Nº HABITANTES DE LA PROVINCIA DE SEVILLA*/
SELECT nom_ciuf, Num_hab
FROM Ciudad 
INNER JOIN Provincia on Id_prov = Id_prov
WHERE Nom_prov = " SEVILLA" ; 
/*4.- CARTEROS ORDENADOS POR SULEDO.*/
SELECT nom_cart, sueldo
from cartero
order by sueldo desc ;
/*5.- NOMBRE DE CIUDAD Y NOMBRE DE ZONA*/
SELECT nom_ciud,sueldo 
FROM ciudad
INNER JOIN zona ON Id_ciud = Id_ciud;
/*6.- ZONAS DE LA „C02‟*/
/*7.- ZONAS DE LA CIUDAD “CIUDAD3”.*/
/*8.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA ZONA “Z01,C02”*/
/*9.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA ZONA CENTRO DE LA CIUDAD1*/
/*10.- NOMBRE DE LOS CARTEROS (Y FECHAS DE INICIO Y FIN) QUE HAN TRABAJADO EN LA RIVERA
DE LA CIUDAD 4.*/
/*11.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN LA PROVINCIA DE SEVILLA*/
/*12.- NOMBRE DE LOS CARTEROS QUE HAN TRABAJADO EN EL PERIODO PE4 Y NOMBRE DE LA
CIUDAD EN QUE ESTABAN TRABAJANDO.*/
/*13.- CARTEROS QUE HAN TRABAJADO EN LA CIUDAD CIUDAD1 Y FECHA DE INICIO Y FIN EN QUE
LO HAN HECHO.*/
/*14.- CARTEROS QUE HAN TRABAJADO EN LA PROVINCIA DE ALMERIA NOMBRE DE ZONA Y
CIUDAD Y FECHAS EN QUE LO HAN HECHO.*/
/*15.- NUMERO DE HABITANTES DE CADA PROVINCIA.*/
/*16.- NOMBRE Y SUELDO DEL CARTERO QUE MÁS PERIODOS HA TRABAJADO*/
/*17.- NOMBRE DE LACIUDAD QUE MAS CARTEROS HA TENIDO.*/
/*18.- NOMBRE DE LA ZONA QUE MAS CARTEROS HA TENIDO (Y Nº DE CARTEROS)*/
/*19.- NOMBRE/S Y SUELDO/S DEL CARTERO QUE HA REPARTIDO EN EL ESTE DE LA CIUDAD3.*/
/*20.- NOMBRE DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA PROVINCIA DE SEVILLA*/
/*21.- NOMBRE Y SUELDO DE LOS CARTEROS QUE NO HAN TRABAJADO EN LA RIVERA DE LA
CIUDAD4.*/
/*22.- FECHA DE INICIO Y FIN DE LOS PERIODOS EN QUE MAS CARTEROS HAN TRABAJADO*/
				