USE ejercicio_1 ;
set SQL_SAFE_UPDATES = 0;
update clientes
set NIF ="43434343A"
where NOMBRE = "DELGADO PEREZ MARISA";
INSERT INTO clientes(NIF, NOMBRE, DOMICILIO, TELF, CIUDAD)
VALUES 	("43434343A", "DELGADO PEREZ MARISA", "C/MIRAMAR, 84 3ºA", "625-200-967", "TOLEDO"),
		("51592939K","LOPEZ VAL SOLEDAD", "C/PEZ, 54 4ºC", "915-829-394","MADRID"),
        ("51639989K","DELGADO ROBLES MIGUEL","C/OCA, 54 5ºC","913-859-293","MADRID"),
        ("51664372R","GUTIERREZ PEREZ ROSA", "C/CASTILLA, 4 4ºA", "919-592-932","MADRID");
SELECT * FROM clientes;
INSERT INTO productos(CODIGO,DESCRIPCION,PRECIO,STOCK,MINIMO)
VALUES 	("CAJ1","CAJA HERRAMIENTAS DE PLASTICO", 8.50,4.00,3),
		("CAJ2","CAJA DE HERRAMIENTAS DE METAL", 12.30,3.00,2),
        ("MAR1","MARTILLO PEQUEÑO",3.50,5,10),
        ("MAR2","MARTILLO GRANDE",6.50,12,10),
        ("TOR7","CAJA TORNILLOS DEL 7",0.80,20,100),
        ("TOR8","CAJA TORNILLOS DEL 9",0.80,25,100),
        ("TUE1","CAJA 100 TUERCAS DEL 7",0.50,40,100),
        ("TUE2","CAJA 100 TUERCAS DEL 9",0.50,54,100),
        ("TUE3","CAJA 100 TUERCAS DEL 12",0.50,60,100);
SELECT * FROM productos;
INSERT INTO facturas(NUMERO,FECHA,PAGADO,NIF_cliente,TOTAL_PRECIO)
VALUES 	(5440,"2017-09-05",TRUE,"51664372R",345),
		(5441,"2017-09-05",FALSE,"51592939K",1000),
        (5442,"2017-09-07",FALSE,"43434343A",789),
        (5443,"2017-09-08",TRUE,"51639989K",123.78),
        (5444,"2017-09-09",TRUE,"51639989K",567),
        (5445,"2017-09-10",TRUE,"51592939K",100);
SELECT * FROM facturas;
INSERT INTO detalle (NUMERO,CODIGO,UNIDADES)
VALUES 	(5440, "CAJ2", 2),
		(5440, "MAR1", 1),
		(5440, "TOR7", 2),
		(5440, "TOR8", 2),
		(5441, "CAJ1", 1),
		(5442, "CAJ1", 1),
		(5442, "MAR1", 2),
		(5443, "TOR7", 1),
		(5443, "TUE1", 1),
		(5444, "MAR2", 1),
		(5445, "TOR7", 5),
		(5445, "TOR8", 5),
		(5445, "TUE2", 5),
		(5445, "TUE3", 5);
select * FRom detalle ;