/*1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto*/
create database if not exists ejercicio_tema8;
use ejercicio_tema8;
delimiter $$ 
drop procedure if exists holaMuno $$
create procedure holaMundo()
begin
select "Hola Mundo";
end
$$
call holaMundo();
/*2. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el
número es positivo, negativo o cero.*/

delimiter $$ 
drop procedure if exists comprobarNumero $$
create procedure comprobarNumero(in numero float)
begin
	if numero > 0 then
	select 'El numeroes positivo' ;
	elseif numero then
			select 'El numero es negativo';
    else 
		select 'El numero es 0';
end if;
end
$$
call comprobarNumero(-25);

/*3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada,
con el valor un número real, y un parámetro de salida, con una cadena de caracteres indicando si el nú-
mero es positivo, negativo o cero.*/
delimiter $$ 
drop procedure if exists comprobarNumero_Ejercicio3 $$
create procedure comprobarNumero_Ejercicio3(in numero float, out signo varchar(15))
begin
	if numero > 0 then
		set signo='positivo';
		elseif numero<0 then
			set signo = 'negativo';
	else 
		set signo='Cero';
	
end if;
end
$$
call comprobarNumero_Ejercicio3(-25,@signo);
select @signo;
/*. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de
un alumno, y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes
condiciones:*/
drop procedure if exists comprobarNota
create procedure comprobarNota (in numero float,out signo varchar(15))
begin
	if numero >= 0 or <5 then 
		set signo = 'Insuficiente';
        elseif numero >=5 or <6 then
			set signo = 'Aprobado';
		elseif numero>=6 or <7 then 
			set signo = 'Bien';
        elseif numero >=7 or <9 then
			set signo = 'Notable';
        elseif numero >=9 or <10 then
			set signo = 'Sobresaliente'
end if
end 
$$
call comprobarNota (8);
select @signo;            