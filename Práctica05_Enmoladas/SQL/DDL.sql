CREATE DATABASE puellaGames;
USE puellaGames;

-- 1#
CREATE TABLE Sucursal (
    IDSucursal VARCHAR(4) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Telefono INT NOT NULL,
    Calle TEXT NOT NULL,
    NumInterior INT NOT NULL,
    NumExterior INT NOT NULL,
    Colonia TEXT NOT NULL,
    Estado TEXT NOT NULL
);

-- Ya debe de estar definida Sucursal antes de los Empleados.

-- 2#
CREATE TABLE Horario (
    IDSucursal VARCHAR(4) NOT NULL,
    HorarioInicio TIMETZ NOT NULL,
    HorarioFinal TIMETZ NOT NULL,
    Dia VARCHAR(9) NOT NULL
);

-- 3#
CREATE TABLE Gerente(
    CURPGerente CHAR(18) PRIMARY KEY,
    IdSucursal VARCHAR(4) NOT NULL,
    RFCGerente CHAR(13) UNIQUE NOT NULL,
    NombreGerente VARCHAR(50) NOT NULL,
    ApellidoPaternoGerente VARCHAR(50) NOT NULL,
    ApellidoMaternoGerente VARCHAR(50) NOT NULL,
    FechaNacimientoGerente DATE NOT NULL,
    FechaContratacionGerente DATE NOT NULL,
    SalarioGerente NUMERIC(12, 2) NOT NULL,
    CedulaProfesional VARCHAR(8) NOT NULL,
    FOREIGN KEY (IdSucursal)
        REFERENCES Sucursal(IdSucursal),
    CHECK SalarioGerente > 0
);

-- 4#
CREATE TABLE TelefonoGerente(
    CURPGerente CHAR(18) NOT NULL,
    TelefonoGerente CHAR(10) PRIMARY KEY,
    FOREIGN KEY (CURPGerente) 
        REFERENCES Gerente(CURPGerente)
);

-- 5#
CREATE TABLE CorreoGerente(
    CURPGerente CHAR(18) NOT NULL,
    CorreoGerente VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (CURPGerente)
        REFERENCES Gerente(CURPGerente)
);

-- 6#
CREATE TABLE EncargadoPremios(
    CURPEncPremios CHAR(18) PRIMARY KEY,
    IdSucursal VARCHAR(4) NOT NULL,
    RFCEncPremios CHAR(13) UNIQUE NOT NULL,
    NombreEncPremios VARCHAR(50) NOT NULL,
    ApellidoPaternoEncPremios VARCHAR(50) NOT NULL,
    ApellidoMaternoEncPremios VARCHAR(50) NOT NULL,
    FechaNacimientoEncPremios DATE NOT NULL,
    FechaContratacionEncPremios DATE NOT NULL,
    SalarioEncPremios NUMERIC(12, 2) NOT NULL,
    EntradaEncPremios TIME NOT NULL,
    SalidaEncPremios TIME NOT NULL,
    FOREIGN KEY (IdSucursal)
        REFERENCES Sucursal(IdSucursal),
    CHECK SalarioEncPremios > 0
);
-- 7#
CREATE TABLE TelefonoEncPremios(
    CURPEncPremios CHAR(18) NOT NULL,
    TelefonoEncPremios CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPEncPremios
        REFERENCES EncargadoPremios(CURPEncPremios)
);

-- 8#
CREATE TABLE CorreoEncPremios(
    CURPEncPremios CHAR(18) NOT NULL,
    CorreoEncPremios VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY CURPEncPremios
        REFERENCES EncargadoPremios(CURPEncPremios)
);

-- 9#
CREATE TABLE Cajero(
    CURPCajero CHAR(18) PRIMARY KEY,
    IdSucursal VARCHAR(4) NOT NULL,
    RFCCajero VARCHAR(13) UNIQUE NOT NULL,
    NombreCajero VARCHAR(50) NOT NULL,
    ApellidoPaternoCajero VARCHAR(50) NOT NULL,
    ApellidoMaternoCajero VARCHAR(50) NOT NULL,
    FechaNacimientoCajero DATE NOT NULL,
    FechaContratacionCajero DATE NOT NULL,
    SalarioCajero NUMERIC(12, 2) NOT NULL,
    EntradaCajero TIME NOT NULL,
    SalidaCajero TIME NOT NULL,
    FOREIGN KEY IdSucursal
        REFERENCES Sucursal(IdSucursal),
    CHECK SalarioCajero > 0
);

-- 10#
CREATE TABLE TelefonoCajero(
    CURPCajero CHAR(18) NOT NULL,
    TelefonoCajero CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPCajero
        REFERENCES Cajero(CURPCajero)
);

-- 11#
CREATE TABLE CorreoCajero(
    CURPCajero CHAR(18) NOT NULL,
    TelefonoCajero CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPCajero
        REFERENCES Cajero(CURPCajero)
);

-- 12#
CREATE TABLE Tecnico(
    CURPTecnico CHAR(18) PRIMARY KEY,
    IdSucursal VARCHAR(4) NOT NULL,
    RFCTecnico CHAR(13) UNIQUE NOT NULL,
    NombreTecnico VARCHAR(50) NOT NULL,
    ApellidoPaternoTecnico VARCHAR(50) NOT NULL,
    ApellidoMaternoTecnico VARCHAR(50) NOT NULL,
    FechaNacimientoTecnico DATE NOT NULL,
    FechaContratacionTecnico DATE NOT NULL,
    SalarioTecnico NUMERIC(12, 2) NOT NULL,
    Especialidad VARCHAR(50) NOT NULL,
    FOREIGN KEY IdSucursal
        REFERENCES Sucursal(IdSucursal),
    CHECK SalarioTecnico > 0
);

-- 13#
CREATE TABLE TelefonoTecnico(
    CURPTecnico CHAR(18) NOT NULL,
    TelefonoTecnico CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPTecnico
        REFERENCES Tecnico(CURPTecnico)
);

-- 14#
CREATE TABLE CorreoTecnico(
    CURPTecnico CHAR(18) NOT NULL,
    CorreoTecnico CHAR(50) PRIMARY KEY,
    FOREIGN KEY CURPTecnico
        REFERENCES Tecnico(CURPTecnico)
);

-- 15#
CREATE TABLE Certificacion(
    CURPTecnico CHAR(18) NOT NULL,
    Certificacion VARCHAR(150) PRIMARY KEY,
    FOREIGN KEY CURPTecnico
        REFERENCES Tecnico(CURPCajero)
);

-- 16#
CREATE TABLE Juego(
	IDJuego INT ,
	Nombre VARCHAR(100) NOT NULL ,
	Costo INT NOT NULL,
	TipoJuego VARCHAR(30) NOT NULL
);

-- 17#
--NOTA
-- Antes de Máquina debe estar definida Sucursal y Juego 
CREATE TABLE Maquina(
	IDMaquina INT  ,
	IDSucursal VARCHAR(4),
	IDJuego INT ,
	EstadoMaquina VARCHAR(30) NOT NULL
);

-- 18#
-- NOTA
-- Antes de RegistroPartida debe estar Tarjeta y Maquina
CREATE TABLE RegistroPartida(
	IDRegistro INT NOT NULL,
	IDMaquina INT NOT NULL,
	NoTarjeta INT NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIMETZ NOT NULL,	
	Puntuacion INT NOT NULL,
);

-- 19#
-- NOTA
-- Antes de Canje debe estar Tarjeta y EncargadoPremios
CREATE TABLE Canje(
	IDCanjeo VARCHAR(4),
	NoTarjeta INT,
	CURPEncPremios CHAR(18),
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL
);

-- 20#
-- NOTA
-- Antes de Canje debe estar Tarjeta y Cajero
CREATE TABLE Recarga(
	CURPCajero CHAR(18),
	NoTarjeta INT,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL,
	Monto MONEY NOT NULL,
	MetodoAbono VARCHAR(12) NOT NULL
);


-- 21#
CREATE TABLE Premio(
	IDPremio VARCHAR(4), 
	Nombre VARCHAR(100) NOT NULL,
	RangoEdad VARCHAR(8) NOT NULL,
	ValorAproximado NUMERIC(6,2) NOT NULL
);

-- 21#
-- NOTA
-- Antes de Guardar debe estar Sucursal y Premio.
CREATE TABLE Guardar (
    IDSucursal VARCHAR(4) NOT NULL,
    IDPremio VARCHAR(4) NOT NULL,
    CantidadInicial INT NOT NULL
);

-- 22#
-- NOTA
-- Antes de Inlcuir debe estar definido Premio y Canjeo.
CREATE TABLE Incluir(
	IDPremio VARCHAR(4),
	IDCanjeo VARCHAR(4),
	Cantidad INT
);


-- Restricciones:

-- Dominio
----- Juego

----- Maquina

----- Premio

----- Incluir
ALTER TABLE Incluir ADD CONSTRAINT Incluir_DOM01
CHECK (Cantidad > 0);

----- RegistroPartida
ALTER TABLE RegistroPartidas ADD CONSTRAINT RegistroPartida_DOM01
CHECK (Puntuacion >= 0);
----- Guardar
ALTER TABLE Guardar ADD CONSTRAINT Guardar_DOM01
CHECK (CantidadInicial >= 0);

-- Entidad
----- RegistroPartida
ALTER TABLE RegistroPartida ADD CONSTRAINT RegistroPartida_PK
PRIMARY KEY (IDRegistro);
----- Sucursal
ALTER TABLE Sucursal ADD CONSTRAINT Sucursal_PK PRIMARY KEY (IDSucursal);
----- Juego
ALTER TABLE Juego ADD CONSTRAINT Juego_PK PRIMARY KEY (IDJuego);
----- Máquina
ALTER TABLE Maquina ADD CONSTRAINT Maquina_PK PRIMARY KEY (IDMaquina);
----- Canje
ALTER TABLE Canje ADD CONSTRAINT Canje_PK PRIMARY KEY (IDCanjeo);
----- Premio
ALTER TABLE Premio ADD CONSTRAINT Premio_PK PRIMARY KEY (IDPremio);
----- Horario
ALTER TABLE Horario ADD CONSTRAINT Horario_PK PRIMARY KEY (IDSucursal, HorarioInicio, HorarioFinal);

-- Referencial

----- Maquina
ALTER TABLE Maquina ADD CONSTRAINT Maquina_FK01S
FOREIGN KEY (IDSucursal) REFERENCES Sucursal (IDSucursal);
ALTER TABLE Maquina ADD CONSTRAINT Maquina_FK02J
FOREIGN KEY (IDJuego) REFERENCES Juego (IDJuego);

----- RegistroPartida
ALTER TABLE RegistroPartida ADD CONSTRAINT  RegistroPartida_FK01M
FOREIGN KEY (IDMaquina) REFERENCES Maquina(IDMaquina);
ALTER TABLE RegistroPartida ADD CONSTRAINT  RegistroPartida_FK02T
FOREIGN KEY (NoTarjeta) REFERENCES Tarjeta(NoTarjeta);

----- Horario
ALTER TABLE Horario ADD CONSTRAINT  Horario_FK01S
FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal);

----- Canje
ALTER TABLE Canje ADD CONSTRAINT  Canje_FK01T
FOREIGN KEY (NoTarjeta) REFERENCES Tarjeta(NoTarjeta);
ALTER TABLE Canje ADD CONSTRAINT  Canje_FK02E
FOREIGN KEY (CURPEncPremios) REFERENCES EncargadoPremios(CURPEncPremios);

----- Recarga
ALTER TABLE Recarga ADD CONSTRAINT  Recarga_FK01C
FOREIGN KEY (CURPCajero) REFERENCES Cajero(CURPCajero);
ALTER TABLE Recarga ADD CONSTRAINT  Recarga_FK02T
FOREIGN KEY (NoTarjeta) REFERENCES Tarjeta(NoTarjeta);

----- Guardar
ALTER TABLE Guardar ADD CONSTRAINT Guardar_FK01S 
FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal);
ALTER TABLE Guardar ADD CONSTRAINT Guardar_FK02P 
FOREIGN KEY (IDPremio) REFERENCES Premio(IDPremio);

----- Inlcuir
ALTER TABLE Incluir ADD CONSTRAINT Incluir_FK01P 
FOREIGN KEY (IDPremio) REFERENCES Premio(IDPremio);
ALTER TABLE Incluir ADD CONSTRAINT Incluir_FK02C 
FOREIGN KEY (IDCanjeo) REFERENCES Canje(IDCanjeo);

