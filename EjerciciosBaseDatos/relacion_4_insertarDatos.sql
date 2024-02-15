use relacion_4;
insert into mecanico (id_mec,nom_mec,sueldo,fec_nac)
values 	("ME1", "JUAN ROMUALDO" ,1289 ,"1970/09/05"),
		("ME2", "RAMON FERNANDEZ" ,1678 ,"1976/07/05"),
		("ME3", "ANA LUCAS" ,1100 ,"1968/09/04");
SELECT * from mecanico ;
insert into coche (mat_co,mod_co,color,tipo)
values 	("1234-CDF", "SEAT LEON", "GRIS", "DIESEL"),
		("0987-CCC", "RENAULT MEGANE", "BLANCO", "GASOLINA"),
		("0123-BVC", "OPEL ASTRA", "AZUL", "DIESEL"),
		("1456-BNL", "FORD FOCUS", "VERDE", "DIESEL"),
		("1111-CSA", "SEAT TOLEDO", "ROJO", "GASOLINA"),
		("4567-BCB", "VOLKSWAGEN POLO", "BLANCO", "DIESEL"),
		("0987-BFG", "FORD FIESTA", "NEGRO", "GASOLINA");
SELECT * from coche;
insert into periodo(id_per,fec_ini,fec_fin)
values 	("PE1", "2003/04/09", "2003/04/10"),
		("PE2", "2004/05/12", "2004/05/17"),
		("PE3", "2004/06/17", "2004/06/27"),
		("PE4", "2005/08/22", "2005/09/1"),
		("PE5", "2005/09/10", "2005/09/15"),
		("PE6", "2005/10/1", "2005/10/17");
SELECT * from periodo;
insert into pieza (id_piez,nom_piez,id_tipo)
values  	("PI1", "FILTRO", "TI4"),
			("PI2", "BATERIA", "TI3"),
			("PI3", "ACEITE", "TI2"),
			("PI4", "RADIO", "TI4"),
			("PI5", "EMBRAGE", "TI2"),
			("PI6", "ALETA", "TI1"),
			("PI7", "PILOTO", "TI3"),
			("PI8", "CALENTADOR", "TI2"),
			("PI9", "CORREAS", "TI4");
SELECT * from pieza;
insert into tipo (id_tipo,nom_tipo)
values		("TI1", "CHAPA"), 
			("TI2", "MECANICA"),
			("TI3", "ELECTRICIDAD"),
			("TI4", "ACCESORIOS");
SELECT * from tipo; 
insert into relacion (id_med,mat_co,id_per,id_piez,precio)
values 	("ME1", "1234-CDF", "PE1", "PI1", 23),
		("ME1", "0123-BVC", "PE2", "PI2", 98),
		("ME1", "1456-BNL", "PE3", "PI6", 124),
		("ME1", "4567-BCB", "PE4", "PI5", 245),
		("ME2", "0987-CCC", "PE1", "PI9", 345),
		("ME2", "0987-CCC", "PE1", "PI8", 232),
		("ME2", "0987-BFG", "PE2", "PI1", 17),
		("ME2", "4567-BCB", "PE3", "PI7", 99),
		("ME2", "1111-CSA", "PE4", "PI4", 124),
		("ME2", "1111-CSA", "PE4", "PI2", 153),
		("ME3", "1456-BNL", "PE6", "PI3", 89),
		("ME3", "1456-BNL", "PE1", "PI4", 232),
		("ME3", "1234-CDF", "PE2", "PI8", 235),
		("ME3", "1111-CSA", "PE3", "PI9", 567),
		("ME3", "0123-BVC", "PE5", "PI6", 232),
		("ME3", "0987-CCC", "PE4", "PI2", 78),
		("ME1", "0987-BFG", "PE5", "PI3", 64),
		("ME2", "1234-CDF", "PE6", "PI5", 234),
		("ME1", "0987-BFG", "PE6", "PI9", 345),
		("ME2", "1234-CDF", "PE6", "PI1", 12),
		("ME1", "1234-CDF", "PE1", "PI6", 187),
		("ME3", "1111-CSA", "PE3", "PI4", 345),
		("ME1", "0123-BVC", "PE2", "PI3", 72),
		("ME2", "0123-BVC", "PE6", "PI3", 89);
SELECT * FROM relacion;