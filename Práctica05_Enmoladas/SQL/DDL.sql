CREATE DATABASE puellaGames;
USE puellaGames;

-- Ya debe de estar definida Sucursal antes de los Empleados.

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

CREATE TABLE TelefonoGerente(
    CURPGerente CHAR(18) NOT NULL,
    TelefonoGerente CHAR(10) PRIMARY KEY,
    FOREIGN KEY (CURPGerente) 
        REFERENCES Gerente(CURPGerente)
);

CREATE TABLE CorreoGerente(
    CURPGerente CHAR(18) NOT NULL,
    CorreoGerente VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (CURPGerente)
        REFERENCES Gerente(CURPGerente)
);

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

CREATE TABLE TelefonoEncPremios(
    CURPEncPremios CHAR(18) NOT NULL,
    TelefonoEncPremios CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPEncPremios
        REFERENCES EncargadoPremios(CURPEncPremios)
);

CREATE TABLE CorreoEncPremios(
    CURPEncPremios CHAR(18) NOT NULL,
    CorreoEncPremios VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY CURPEncPremios
        REFERENCES EncargadoPremios(CURPEncPremios)
);

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

CREATE TABLE TelefonoCajero(
    CURPCajero CHAR(18) NOT NULL,
    TelefonoCajero CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPCajero
        REFERENCES Cajero(CURPCajero)
);

CREATE TABLE CorreoCajero(
    CURPCajero CHAR(18) NOT NULL,
    TelefonoCajero CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPCajero
        REFERENCES Cajero(CURPCajero)
);

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

CREATE TABLE TelefonoTecnico(
    CURPTecnico CHAR(18) NOT NULL,
    TelefonoTecnico CHAR(10) PRIMARY KEY,
    FOREIGN KEY CURPTecnico
        REFERENCES Tecnico(CURPTecnico)
);

CREATE TABLE CorreoTecnico(
    CURPTecnico CHAR(18) NOT NULL,
    CorreoTecnico CHAR(50) PRIMARY KEY,
    FOREIGN KEY CURPTecnico
        REFERENCES Tecnico(CURPTecnico)
);

CREATE TABLE Certificacion(
    CURPTecnico CHAR(18) NOT NULL,
    Certificacion VARCHAR(150) PRIMARY KEY,
    FOREIGN KEY CURPTecnico
        REFERENCES Tecnico(CURPCajero)
);

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

-- Restricciones RegistroPartida
-- Dominio
ALTER TABLE RegistroPartidas ADD CONSTRAINT RegistroPartida_DOM01
CHECK (Puntuacion >= 0);

-- Entidad
ALTER TABLE RegistroPartida ADD CONSTRAINT RegistroPartida_PK
PRIMARY KEY (IDRegistro);

-- Referencial
ALTER TABLE RegistroPartida ADD CONSTRAINT  RegistroPartida_FK01M
FOREIGN KEY (IDMaquina) REFERENCES Maquina(IDMaquina);

ALTER TABLE RegistroPartida ADD CONSTRAINT  RegistroPartida_FK01M
FOREIGN KEY (NoTarjeta) REFERENCES Maquina(NoTarjeta);


