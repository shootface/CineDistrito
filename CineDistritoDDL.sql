/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 25-may-2019 19:05:54 				*/
/*  DBMS       : PostgreSQL 						*/
/* ---------------------------------------------------- */

/* Drop Tables */

DROP TABLE IF EXISTS Cliente CASCADE
;

DROP TABLE IF EXISTS Contrato CASCADE
;

DROP TABLE IF EXISTS Empleado CASCADE
;

DROP TABLE IF EXISTS Empleado_Multiplex CASCADE
;

DROP TABLE IF EXISTS Funcion CASCADE
;

DROP TABLE IF EXISTS Multiplex CASCADE
;

DROP TABLE IF EXISTS Pago CASCADE
;

DROP TABLE IF EXISTS Pelicula CASCADE
;

DROP TABLE IF EXISTS Persona CASCADE
;

DROP TABLE IF EXISTS Reserva CASCADE
;

DROP TABLE IF EXISTS Sala CASCADE
;

DROP TABLE IF EXISTS Silla CASCADE
;

DROP TABLE IF EXISTS Silla_Funcion CASCADE
;

DROP TABLE IF EXISTS Snack CASCADE
;

DROP TABLE IF EXISTS Snack_Reserva CASCADE
;

/* Create Tables */

CREATE TABLE Cliente
(
	fk_persona integer NOT NULL,
	i_numPuntos integer NOT NULL,
	i_numTarjeta varchar(50) NOT NULL,
	d_fechaPuntos varchar(50) NOT NULL
)
;

CREATE TABLE Contrato
(
	id integer NOT NULL,
	v_tipoContrato varchar(100) NOT NULL,
	d_inicioContrato date NOT NULL,
	i_salario integer NOT NULL
)
;

CREATE TABLE Empleado
(
	fk_persona integer NOT NULL,
	fk_contrato integer NOT NULL,
	n_descuento numeric(4,2) NOT NULL,
	fk_numContrato integer NULL
)
;

CREATE TABLE Empleado_Multiplex
(
	id integer NOT NULL,
	fk_empleado integer NOT NULL,
	fk_multiplex integer NOT NULL,
	f_transferencia timestamp without time zone NOT NULL
)
;

CREATE TABLE Funcion
(
	id integer NOT NULL,
	v_estado varchar(50) NOT NULL,
	d_proyeccion date NOT NULL,
	fk_pelicula integer NOT NULL,
	t_inicioProyeccion time without time zone NOT NULL,
	t_finProyeccion time without time zone NOT NULL
)
;

CREATE TABLE Multiplex
(
	id integer NOT NULL,
	v_nombre varchar(100) NOT NULL,
	v_direccion varchar(100) NOT NULL,
	v_ciudad varchar(100) NOT NULL,
	i_minSalas integer NOT NULL,
	i_maxSalas integer NOT NULL
)
;

CREATE TABLE Pago
(
	pk_numPago integer NOT NULL,
	t_fechaPago timestamp without time zone NOT NULL,
	i_subtotalPago integer NOT NULL,
	i_totalPago integer NOT NULL,
	i_puntosGanados integer NOT NULL,
	v_metodoPago varchar(50) NOT NULL,
	fk_cliente integer NOT NULL,
	fk_reserva integer NULL
)
;

CREATE TABLE Pelicula
(
	id integer NOT NULL,
	v_nombre varchar(150) NOT NULL,
	i_duracion integer NOT NULL,
	tx_sinapsis text NOT NULL,
	v_foto varchar(150) NOT NULL
)
;

CREATE TABLE Persona
(
	pk_cedula integer NOT NULL,
	v_primerNombre varchar(100) NOT NULL,
	v_segundoNombre varchar(100) NULL,
	v_primerApellido varchar(100) NOT NULL,
	v_segundoApellido varchar(100) NOT NULL,
	i_telefono integer NOT NULL,
	v_direccion varchar(100) NOT NULL
)
;

CREATE TABLE Reserva
(
	id integer NOT NULL,
	v_estado varchar(50) NOT NULL,
	t_inicioReserva time without time zone NOT NULL,
	fk_persona integer NOT NULL
)
;

CREATE TABLE Sala
(
	id integer NOT NULL,
	i_numPreferencial integer NOT NULL,
	i_numGeneral integer NOT NULL,
	fk_multiplex integer NOT NULL
)
;

CREATE TABLE Silla
(
	pk_numero varchar(3) NOT NULL,
	fk_sala integer NOT NULL,
	v_tipo varchar(50) NOT NULL,
	i_orden varchar(50) NOT NULL,
	fk_multiplex integer NOT NULL
)
;

CREATE TABLE Silla_Funcion
(
	id integer NOT NULL,
	v_estado varchar(50) NOT NULL,
	fk_silla varchar(3) NOT NULL,
	fk_funcion integer NOT NULL,
	fk_sala integer NOT NULL,
	fk_multiplex integer NOT NULL,
	fk_reserva integer NULL
)
;

CREATE TABLE Snack
(
	id integer NOT NULL,
	v_tipo varchar(50) NOT NULL,
	v_nombre varchar(50) NOT NULL,
	tx_descripcion text NOT NULL,
	i_precio integer NOT NULL,
	i_puntosOfrecidos integer NULL
)
;

CREATE TABLE Snack_Reserva
(
	fk_reserva integer NOT NULL,
	fk_snack integer NOT NULL,
	i_cantidad integer NOT NULL
)
;

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE Cliente ADD CONSTRAINT PK_Cliente
	PRIMARY KEY (fk_persona)
;

CREATE INDEX IXFK_Cliente_Persona ON Cliente (fk_persona ASC)
;

ALTER TABLE Contrato ADD CONSTRAINT PK_Contrato
	PRIMARY KEY (id)
;

ALTER TABLE Empleado ADD CONSTRAINT PK_Empleado
	PRIMARY KEY (fk_persona)
;

CREATE INDEX IXFK_Empleado_Contrato ON Empleado (fk_numContrato ASC)
;

CREATE INDEX IXFK_Empleado_Persona ON Empleado (fk_persona ASC)
;

ALTER TABLE Empleado_Multiplex ADD CONSTRAINT PK_Empleado_Multiplex
	PRIMARY KEY (id)
;

CREATE INDEX IXFK_Empleado_Multiplex_Empleado ON Empleado_Multiplex (fk_empleado ASC)
;

CREATE INDEX IXFK_Empleado_Multiplex_Multiplex ON Empleado_Multiplex (fk_multiplex ASC)
;

ALTER TABLE Funcion ADD CONSTRAINT PK_Funcion
	PRIMARY KEY (id)
;

CREATE INDEX IXFK_Funcion_Pelicula ON Funcion (fk_pelicula ASC)
;

ALTER TABLE Multiplex ADD CONSTRAINT PK_Multiplex
	PRIMARY KEY (id)
;

ALTER TABLE Pago ADD CONSTRAINT PK_Pago
	PRIMARY KEY (pk_numPago)
;

CREATE INDEX IXFK_Pago_Cliente ON Pago (fk_cliente ASC)
;

CREATE INDEX IXFK_Pago_Reserva ON Pago (fk_reserva ASC)
;

ALTER TABLE Pelicula ADD CONSTRAINT PK_Pelicula
	PRIMARY KEY (id)
;

ALTER TABLE Persona ADD CONSTRAINT PK_Persona
	PRIMARY KEY (pk_cedula)
;

ALTER TABLE Reserva ADD CONSTRAINT PK_Reserva
	PRIMARY KEY (id)
;

CREATE INDEX IXFK_Reserva_Persona ON Reserva (fk_persona ASC)
;

ALTER TABLE Sala ADD CONSTRAINT PK_Sala
	PRIMARY KEY (id,fk_multiplex)
;

CREATE INDEX IXFK_Sala_Multiplex ON Sala (fk_multiplex ASC)
;

ALTER TABLE Silla ADD CONSTRAINT PK_Silla
	PRIMARY KEY (pk_numero,fk_sala,fk_multiplex)
;

CREATE INDEX IXFK_Silla_Sala ON Silla (fk_sala ASC,fk_multiplex ASC)
;

ALTER TABLE Silla_Funcion ADD CONSTRAINT PK_Silla_Funcion
	PRIMARY KEY (id)
;

CREATE INDEX IXFK_Silla_Funcion_Funcion ON Silla_Funcion (fk_funcion ASC)
;

CREATE INDEX IXFK_Silla_Funcion_Reserva ON Silla_Funcion (fk_reserva ASC)
;

CREATE INDEX IXFK_Silla_Funcion_Silla ON Silla_Funcion (fk_silla ASC,fk_sala ASC,fk_multiplex ASC)
;

ALTER TABLE Snack ADD CONSTRAINT PK_Snack
	PRIMARY KEY (id)
;

ALTER TABLE Snack_Reserva ADD CONSTRAINT PK_Snack_Reserva
	PRIMARY KEY (fk_snack,fk_reserva)
;

CREATE INDEX IXFK_Snack_Reserva_Reserva ON Snack_Reserva (fk_reserva ASC)
;

CREATE INDEX IXFK_Snack_Reserva_Snack ON Snack_Reserva (fk_snack ASC)
;

/* Create Foreign Key Constraints */

ALTER TABLE Cliente ADD CONSTRAINT FK_Cliente_Persona
	FOREIGN KEY (fk_persona) REFERENCES Persona (pk_cedula) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Empleado ADD CONSTRAINT FK_Empleado_Contrato
	FOREIGN KEY (fk_numContrato) REFERENCES Contrato (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Empleado ADD CONSTRAINT FK_Empleado_Persona
	FOREIGN KEY (fk_persona) REFERENCES Persona (pk_cedula) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Empleado_Multiplex ADD CONSTRAINT FK_Empleado_Multiplex_Empleado
	FOREIGN KEY (fk_empleado) REFERENCES Empleado (fk_persona) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Empleado_Multiplex ADD CONSTRAINT FK_Empleado_Multiplex_Multiplex
	FOREIGN KEY (fk_multiplex) REFERENCES Multiplex (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Funcion ADD CONSTRAINT FK_Funcion_Pelicula
	FOREIGN KEY (fk_pelicula) REFERENCES Pelicula (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Pago ADD CONSTRAINT FK_Pago_Cliente
	FOREIGN KEY (fk_cliente) REFERENCES Cliente (fk_persona) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Pago ADD CONSTRAINT FK_Pago_Reserva
	FOREIGN KEY (fk_reserva) REFERENCES Reserva (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Reserva ADD CONSTRAINT FK_Reserva_Persona
	FOREIGN KEY (fk_persona) REFERENCES Persona (pk_cedula) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Sala ADD CONSTRAINT FK_Sala_Multiplex
	FOREIGN KEY (fk_multiplex) REFERENCES Multiplex (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Silla ADD CONSTRAINT FK_Silla_Sala
	FOREIGN KEY (fk_sala,fk_multiplex) REFERENCES Sala (id,fk_multiplex) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Silla_Funcion ADD CONSTRAINT FK_Silla_Funcion_Funcion
	FOREIGN KEY (fk_funcion) REFERENCES Funcion (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Silla_Funcion ADD CONSTRAINT FK_Silla_Funcion_Reserva
	FOREIGN KEY (fk_reserva) REFERENCES Reserva (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Silla_Funcion ADD CONSTRAINT FK_Silla_Funcion_Silla
	FOREIGN KEY (fk_silla,fk_sala,fk_multiplex) REFERENCES Silla (pk_numero,fk_sala,fk_multiplex) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Snack_Reserva ADD CONSTRAINT FK_Snack_Reserva_Reserva
	FOREIGN KEY (fk_reserva) REFERENCES Reserva (id) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE Snack_Reserva ADD CONSTRAINT FK_Snack_Reserva_Snack
	FOREIGN KEY (fk_snack) REFERENCES Snack (id) ON DELETE No Action ON UPDATE No Action
;
