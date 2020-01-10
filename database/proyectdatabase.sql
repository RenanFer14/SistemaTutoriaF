use master
go
if exists (select * from sysdatabases where name='BDTutoria' )
	drop database BDTutoria
go
create database BDTutoria
go

use BDTutoria
go
/* Crear los tipos*/
CREATE TYPE CodDocente FROM varchar(10) NOT NULL;
go
CREATE TYPE CodEstudiante FROM varchar(10) NOT NULL;
go
CREATE TYPE CodListaTutorado FROM varchar(10) NOT NULL;
go
CREATE TYPE CodSolicitudCita FROM varchar(10) NOT NULL;
go
CREATE TYPE CodSolicitudCambio FROM varchar(10) NOT NULL;
go
CREATE TYPE CodAtencionEspecial FROM varchar(10) NOT NULL;
go
CREATE TYPE CodHorarioDocente FROM varchar(10) NOT NULL;
go
CREATE TYPE CodHorarioEstudiante FROM varchar(10) NOT NULL;
go
CREATE TYPE CodEvaluarTutor FROM varchar(10) NOT NULL;
go

--------------------------------------------
----------CREACION DE LAS TABLAS -----------
--------------------------------------------
create table TDocente
(
    CodDocente CodDocente NOT NULL,
	Contraseña varchar(20),
	Nombre varchar(20),
	APaterno varchar(20),
	AMaterno varchar(20),
	Estado varchar(10),--Activo: es tutor. No Activo: no es tutor
	Direccion varchar(40),
	primary key(CodDocente)
)
go

create table TEstudiante
(
    CodEstudiante CodEstudiante NOT NULL,
	Contraseña varchar(20) not null,
	Nombre varchar(20) not null,
	APaterno varchar(20) not null,
	AMaterno varchar(20) not null,
	Estado varchar(10),--Activo: es Tutorado, No Activo:No es tutorado
	FechaNacimiento datetime,
	Distrito varchar(20),
	Provincia varchar(20),
	Region varchar(20),
	NombrePadre varchar(50),
	NombreMadre varchar(50)
	primary key(CodEstudiante)
)
go
create table TListaTutorados
(
    CodListaTutorado CodListaTutorado NOT NULL,
	CodDocente varchar(10) not null,
	CodEstudiante varchar(10) not null,
	primary key(CodListaTutorado,CodDocente,CodEstudiante),
	foreign key(CodDocente) references TDocente(CodDocente),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante),
)
go
create table TSolicitudCita
(
    CodSolicitudCita CodSolicitudCita NOT NULL,
	CodDocente varchar(10) not null,
	CodEstudiante varchar(10) not null,
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
create table TSolicitudCambio
(
    CodSolicitudCambio CodSolicitudCambio NOT NULL,
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
create table TAtencionEspecial
(
    CodAtencionEspecial CodAtencionEspecial NOT NULL,
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
create table THorarioDocente
(
    CodHorarioDocente CodHorarioDocente NOT NULL,
	CodDocente varchar(10),
	Semestre varchar(10),
	primary key(CodHorarioDocente),
	foreign key(CodDocente) references TDocente(CodDocente) 
)
go
create table THorarioEstudiante
(
    CodHorarioEstudiante CodHorarioEstudiante NOT NULL,
	CodEstudiante varchar(10),
	Semestre varchar(10),
	primary key(CodHorarioEstudiante),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante) 
)
go
create table THorarioDetalleDocente
(
    CodHorarioDocente CodHorarioDocente NOT NULL,
	Hora varchar(10),
	Lunes varchar(25),
	Martes varchar(25),
	Miercoles varchar(25),
	Jueves varchar(25),
	Viernes varchar(25),
	primary key(CodHorarioDocente,Hora),
	foreign key(CodHorarioDocente) references THORARIODOCENTE(CodHorarioDocente)
)
go
create table THorarioDetalleEstudiante
(
    CodHorarioEstudiante CodHorarioEstudiante NOT NULL,
	Hora varchar(10),
	Lunes varchar(25),
	Martes varchar(25),
	Miercoles varchar(25),
	Jueves varchar(25),
	Viernes varchar(25),
	primary key(CodHorarioEstudiante,Hora),
	foreign key(CodHorarioEstudiante) references THORARIOESTUDIANTE(CodHorarioEstudiante)
)
go
create table TEvaluarTutor
(
    CodEvaluarTutor CodEvaluarTutor NOT NULL,
	CodDocente varchar(10),
	CodEstudiante varchar(10),
	primary key(CodEvaluarTutor),
	foreign key(CodDocente) references TDocente(CodDocente),
	foreign key(CodEstudiante) references TEstudiante(CodEstudiante)	
)
go


-------------------------------------------DOCENTE-------------------------------------------
insert into TDocente values('114623','123456789','Pedro','Bustamante','Solis','Activo','Av. La Cultura Nro 113')
insert into TDocente values('124843','987654321','Juan Pedro','Moran','Arquimides','Activo','Av. Ccollasuyo Nro 713')
insert into TDocente values('154724','123456','Luis','Boris','Montreal','Activo','Av. Navl Nro 193')

-------------------------------------------ESTUDIANTE-------------------------------------------
insert into TEstudiante values('154627','123456789','Juan','Chacon','Villena','Activo','07/05/1992','','','','','')
insert into TEstudiante values('164778','132652899','Fernando','Acuña','Fujimori','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164779','132652899','Franco','Mogrovejo','Zamalloa','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164780','132653899','Lucio','Lopez','Mosqueira','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164781','132654899','Angel','Lozano','Licona','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164178','132655899','Pepe','Zapata','Gonzales','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164278','132656999','Maria','Mendigure','Estrada','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164378','132657891','Fernanda','Nina','Ponce','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164478','132657892','Marco','Torres','Ramirez','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164578','132657893','Antonio','Villacorta','Villafuerte','Activo','07/05/1997','','','','','')
insert into TEstudiante values('164678','132657894','Daniel','Guillen','Duran','Activo','07/05/1997','','','','','')
insert into TEstudiante values('167778','132657895','Javier','Callasaca','Palomino','Activo','07/05/1997','','','','','')
insert into TEstudiante values('168778','132657896','Jose','Mulder','Quispe','Activo','07/05/1997','','','','','')
insert into TEstudiante values('169778','132657897','Ruben','Fernandez','Barnechea','Activo','07/05/1997','','','','','')
insert into TEstudiante values('112778','132657898','Jesus','Peralta','Guzman','Activo','07/05/1997','','','','','')

-------------------------------------------TListaTutorados-------------------------------------------
insert into TListaTutorados values('L2018201','154724','154627')
--insert into TListaTutorados values('L2018201','154724','164778')
--insert into TListaTutorados values('L2018201','154724','164779')
--insert into TListaTutorados values('L2018201','154724','164780')
--insert into TListaTutorados values('L2018201','154724','164781')
insert into TListaTutorados values('L2018202','154623','164178')-----
--insert into TListaTutorados values('L2018202','154623','164278')
--insert into TListaTutorados values('L2018202','154623','164378')
--insert into TListaTutorados values('L2018203','154623','164478')----
-------------------------------------------THORARIO-------------------------------------------
insert into THorarioDocente values('H0001','114623','2018-II')
insert into THorarioDetalleDocente values('H0001','07-08','IN203','','IN203','','IN203')
insert into THorarioDetalleDocente values('H0001','08-09','IN203','','IN203','','')
insert into THorarioDetalleDocente values('H0001','09-10','','IN303','','IN303','')
insert into THorarioDetalleDocente values('H0001','10-11','','IN303','','IN303','')
insert into THorarioDetalleDocente values('H0001','11-12','','','','','')
insert into THorarioDetalleDocente values('H0001','12-13','','','','','')

--ejemplos 
select* from THorarioDetalleDocente
select* from TDocente
select* from TEstudiante
select * from TListaTutorados where CodListaTutorado='L2018201'
