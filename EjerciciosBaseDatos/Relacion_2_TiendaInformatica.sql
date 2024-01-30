/*1. Crea una base de datos llamada TIENDA*/
CREATE DATABASE IF NOT EXISTS Tienda;
/*2. Muestra las Bases de datos almacenadas*/
show databases;
/*3. Habilita la Base de datos TIENDA*/
USE Tienda;
/*4. Genera las siguientes tablas:*/
CREATE TABLE IF NOT EXISTS fabricantes(
clave_fabricante INT primary key,
nombre VARCHAR(30)
);
CREATE TABLE IF NOT EXISTS articulos(
clave_articulo INT primary key,
nombre VARCHAR(30),
precio INT,
clave_fabricante INT, 
foreign key (clave_fabricante) references fabricantes(clave_fabricante)
);
/*6. Muestra los atributos de la tabla ARTICULOS*/
describe articulos;
/*Muestra las tablas de la base de datos tienda*/
show tables;
