use master
go
if exists (select * from sysdatabases where name='BDTutoria' )
	drop database BDTutoria
go
create database BDTutoria
go
--------------------------------------------
----------CREACION DE LAS TABLAS -----------
--------------------------------------------
use BDTutoria
go

CREATE TYPE TCodHorarioDocente FROM varchar(10) NOT NULL;
go
create table TDOCENTE
(
    CodDocente varchar(10),
	Contraseña varchar(20),
	Nombre varchar(20),
	APaterno varchar(20),
	AMaterno varchar(20),
	Estado varchar(10),--Activo: es tutor. No Activo: no es tutor
	Direccion varchar(40),
	primary key(CodDocente)
)
go

create table TESTUDIANTE
(
    CodEstudiante varchar(10),
	Contraseña varchar(20),
	Nombre varchar(20),
	APaterno varchar(20),
	AMaterno varchar(20),
	Estado varchar(10),--Activo: es Tutorado, No Activo:No es tutorado
	FechaNacimiento datetime,
	Distrito varchar(20),
	Provincia varchar(20),
	Region varchar(20),
	Padre varchar(50),
	Madre varchar(50)
	primary key(CodEstudiante)
)
go
create table TLISTATUTORADOS
(
    CodListaTutorado varchar(10),
	CodDocente varchar(10),
	CodEstudiante varchar(10),
	primary key(CodListaTutorado),
	foreign key(CodDocente) references TDocente(CodDocente),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante),
)
go
create table TSOLICITUDCITA
(
    CodSolicitudCita varchar(10),
	CodDocente varchar(10),
	CodEstudiante varchar(10),
	Razon varchar(50),
	FechaSolicitud datetime,
	Hora varchar(10),
	AceptacionONegacion varchar(10),
	FechaAceptacionONegacion datetime,
	primary key(CodSolicitudCita),
	foreign key(CodDocente) references TDocente(CodDocente),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante),
)
go
create table TSOLICITUDCAMBIO
(
    CodSolicitudCambio varchar(10),
	CodDocente varchar(10),
	CodEstudiante varchar(10),
	Razon varchar(50),
	FechaSolicitud datetime,
	AceptacionONegacion varchar(10),
	FechaAceptacionONegacion datetime,
	primary key(CodSolicitudCambio),
	foreign key(CodDocente) references TDocente(CodDocente),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante)
)
go
create table TATENCIONESPECIAL
(
    CodAtencionEspecial varchar(10),
	CodDocente varchar(10),
	CodEstudiante varchar(10),	
	FechaDerivación datetime,
	Comentario varchar(50),
	TipoDerivacion varchar(20),
	primary key(CodAtencionEspecial),
	foreign key(CodDocente) references TDocente(CodDocente),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante)
)
go
create table THORARIODOCENTE
(
    CodHorarioDocente TCodHorarioDocente NOT NULL,
	CodDocente varchar(10),
	Semestre varchar(10),
	primary key(CodHorarioDocente),
	foreign key(CodDocente) references TDocente(CodDocente) 
)
go
create table THORARIOESTUDIANTE
(
    CodHorarioEstudiante varchar(10),
	CodEstudiante varchar(10),
	Semestre varchar(10),
	primary key(CodHorarioEstudiante),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante) 
)
go
create table THORARIODIADOCENTE
(
    CodHorarioDocente TCodHorarioDocente NOT NULL,
	Hora varchar(10),
	Lunes varchar(25),
	Martes varchar(25),
	Miercoles varchar(25),
	Jueves varchar(25),
	Viernes varchar(25),
	primary key(CodHorarioDocente,hora),
	foreign key(CodHorarioDocente) references THORARIODOCENTE(CodHorarioDocente)
)
go
create table THORARIODIAESTUDIANTE
(
    CodHorarioEstudiante varchar(10),
	Hora varchar(10),
	Lunes varchar(25),
	Martes varchar(25),
	Miercoles varchar(25),
	Jueves varchar(25),
	Viernes varchar(25),
	primary key(CodHorarioEstudiante),
	foreign key(CodHorarioEstudiante) references THORARIOESTUDIANTE(CodHorarioEstudiante)
)
go
create table TEVALUARTUTOR
(
    CodEvaluarTutor varchar(10),
	CodDocente varchar(10),
	CodEstudiante varchar(10),
	primary key(CodEvaluarTutor),
	foreign key(CodDocente) references TDocente(CodDocente),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante)	
)
go


-------------------------------------------DOCENTE-------------------------------------------
insert into TDOCENTE values('114623','123456789','Pedro','Bustamante','Solis','Activo','Av. La Cultura Nro 113')
insert into TDOCENTE values('124843','987654321','Juan Pedro','Moran','Arquimides','Activo','Av. Ccollasuyo Nro 713')
insert into TDOCENTE values('154724','123456','Luis','Boris','Montreal','No Activo','Av. Navl Nro 193')

-------------------------------------------ESTUDIANTE-------------------------------------------
insert into TESTUDIANTE values('154627','123456789','Juan','Chacon','Villena','Activo','07/05/1992','','','','','')
insert into TESTUDIANTE values('164778','132657899','Fernando','Acuña','Fujimori','No Activo','07/05/1997','','','','','')

-------------------------------------------THORARIO-------------------------------------------
insert into THORARIODOCENTE values('H0001','114623','2018-II')
insert into THORARIODIADOCENTE values('H0001','7-8','IN203','','IN203','','IN203')
insert into THORARIODIADOCENTE values('H0001','8-9','IN203','','IN203','','')
insert into THORARIODIADOCENTE values('H0001','9-10','','IN303','','IN303','')
insert into THORARIODIADOCENTE values('H0001','10-11','','IN303','','IN303','')
insert into THORARIODIADOCENTE values('H0001','11-12','','','','','')
insert into THORARIODIADOCENTE values('H0001','12-13','','','','','')

--ejemplos 
select* from THORARIODIADOCENTE
