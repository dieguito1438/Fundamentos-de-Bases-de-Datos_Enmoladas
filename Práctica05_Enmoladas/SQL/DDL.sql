CREATE DATABASE puellaGames;
USE puellaGames;

-- 1# SUCURSAL
CREATE TABLE Sucursal (
    IDSucursal INT ,
    Nombre VARCHAR(100) NOT NULL,
    Telefono INT NOT NULL,
    Calle TEXT NOT NULL,
    NumInterior INT NOT NULL,
    NumExterior INT NOT NULL,
    Colonia TEXT NOT NULL,
    Estado TEXT NOT NULL
);

-- Ya debe de estar definida Sucursal antes de los Empleados.

-- 2# HORARIO
CREATE TABLE Horario (
    HorarioInicio TIMETZ ,
    HorarioFinal TIMETZ ,
    IDSucursal INT ,
    Dia VARCHAR(9) NOT NULL
);

-- 3# GERENTE
CREATE TABLE Gerente(
    CURPGerente CHAR(18),
    IDSucursal INT,
    RFCGerente CHAR(13)
    NombreGerente VARCHAR(50),
    ApellidoPaternoGerente VARCHAR(50),
    ApellidoMaternoGerente VARCHAR(50),
    FechaNacimientoGerente DATE,
    FechaContratacionGerente DATE,
    SalarioGerente NUMERIC(12, 2),
    CedulaProfesional VARCHAR(8)
);

ALTER TABLE Gerente
    ADD CONSTRAINT GerentePK PRIMARY KEY (CURPGerente),
    ADD CONSTRAINT GerenteFK FOREIGN KEY (IDSucursal)
        REFERENCES Sucursal(IDSucursal),
    ADD CONSTRAINT RFCGerente_unico UNIQUE (RFCGerente),
    ADD CONSTRAINT CedulaGerente_unico UNIQUE (CedulaProfesional),
    ADD CONSTRAINT SalarioGerente_valido CHECK (SalarioGerente > 0),
    ALTER COLUMN RFCGerente SET NOT NULL,
    ALTER COLUMN NombreGerente SET NOT NULL,
    ALTER COLUMN ApellidoPaternoGerente SET NOT NULL,
    ALTER COLUMN ApellidoMaternoGerente SET NOT NULL,
    ALTER COLUMN FechaContratacionGerente SET NOT NULL,
    ALTER COLUMN FechaNacimientoGerente SET NOT NULL,
    ALTER COLUMN SalarioGerente SET NOT NULL,
    ALTER COLUMN CedulaProfesional SET NOT NULL;


-- 4# TELEFONO GERENTE
CREATE TABLE TelefonoGerente(
    CURPGerente CHAR(18),
    TelefonoGerente CHAR(10)
);

ALTER TABLE TelefonoGerente
    ADD CONSTRAINT TelefonoGerentePK PRIMARY KEY (TelefonoGerente),
    ADD CONSTRAINT TelefonoGerenteFK FOREIGN KEY (CURPGerente)
        REFERENCES Gerente(CURPGerente),
    ALTER COLUMN TelefonoGerente SET NOT NULL,
    ALTER COLUMN CURPGerente SET NOT NULL;


-- 5# CORREO GERENTE
CREATE TABLE CorreoGerente(
    CURPGerente CHAR(18),
    CorreoGerente VARCHAR(50)
);

ALTER TABLE CorreoGerente
    ADD CONSTRAINT CorreoGerentePK PRIMARY KEY (CorreoGerente),
    ADD CONSTRAINT CorreoGerenteFK FOREIGN KEY (CURPGerente)
        REFERENCES Gerente(CURPGerente),
    ALTER COLUMN CorreoGerente SET NOT NULL,
    ALTER COLUMN CURPGerente SET NOT NULL;


-- 6# ENCARGADO PREMIOS
CREATE TABLE EncargadoPremios(
    CURPEncPremios CHAR(18),
    IDSucursal INT,
    RFCEncPremios CHAR(13),
    NombreEncPremios VARCHAR(50),
    ApellidoPaternoEncPremios VARCHAR(50),
    ApellidoMaternoEncPremios VARCHAR(50),
    FechaNacimientoEncPremios DATE,
    FechaContratacionEncPremios DATE,
    SalarioEncPremios NUMERIC(12, 2),
    EntradaEncPremios TIME,
    SalidaEncPremios TIME
);

ALTER TABLE EncargadoPremios
    ADD CONSTRAINT EncPremiosPK PRIMARY KEY (CURPEncPremios),
    ADD CONSTRAINT EncPremiosFK FOREIGN KEY (IDSucursal)
        REFERENCES Sucursal(IDSucursal),
    ADD CONSTRAINT RFCEncPremios_unico UNIQUE (RFCEncPremios),
    ADD CONSTRAINT SalarioEncPremios_valido CHECK (SalarioEncPremios > 0),
    ALTER COLUMN IDSucursal SET NOT NULL,
    ALTER COLUMN RFCEncPremios SET NOT NULL,
    ALTER COLUMN NombreEncPremios SET NOT NULL,
    ALTER COLUMN ApellidoPaternoEncPremios SET NOT NULL,
    ALTER COLUMN ApellidoMaternoEncPremios SET NOT NULL,
    ALTER COLUMN FechaNacimientoEncPremios SET NOT NULL,
    ALTER COLUMN FechaContratacionEncPremios SET NOT NULL,
    ALTER COLUMN SalarioEncPremios SET NOT NULL,
    ALTER COLUMN EntradaEncPremios SET NOT NULL;


-- 7# TELEFONO ENCARGADO PREMIOS
CREATE TABLE TelefonoEncPremios(
    CURPEncPremios CHAR(18),
    TelefonoEncPremios CHAR(10)
);

ALTER TABLE TelefonoEncPremios
    ADD CONSTRAINT TelefonoEncPremiosPK PRIMARY KEY (TelefonoEncPremios),
    ADD CONSTRAINT TelefonoEncPremiosFK FOREIGN KEY (CURPEncPremios)
        REFERENCES EncargadoPremios(CURPEncPremios),
    ALTER COLUMN TelefonoEncPremios SET NOT NULL,
    ALTER COLUMN CURPEncPremios SET NOT NULL;


-- 8# CORREO ENCARGADO PREMIOS
CREATE TABLE CorreoEncPremios(
    CURPEncPremios CHAR(18),
    CorreoEncPremios VARCHAR(50)
);

ALTER TABLE CorreoEncPremios
    ADD CONSTRAINT CorreoEncPremiosPK PRIMARY KEY (CorreoEncPremios),
    ADD CONSTRAINT CorreoEncPremiosKF FOREIGN KEY (CURPEncPremios)
        REFERENCES EncargadoPremios(CURPEncPremios),
    ALTER COLUMN CorreoEncPremios SET NOT NULL,
    ALTER COLUMN CURPEncPremios SET NOT NULL;


-- 9# CAJERO
CREATE TABLE Cajero(
    CURPCajero CHAR(18),
    IDSucursal VARCHAR(4),
    RFCCajero VARCHAR(13),
    NombreCajero VARCHAR(50),
    ApellidoPaternoCajero VARCHAR(50),
    ApellidoMaternoCajero VARCHAR(50),
    FechaNacimientoCajero DATE,
    FechaContratacionCajero DATE,
    SalarioCajero NUMERIC(12, 2),
    EntradaCajero TIME,
    SalidaCajero TIME
);

ALTER TABLE Cajero
    ADD CONSTRAINT CajeroPK PRIMARY KEY (CURPCajero),
    ADD CONSTRAINT CajeroFK FOREIGN KEY (IDSucursal)
        REFERENCES Sucursal(IDSucursal),
    ADD CONSTRAINT RFCCajero_unico UNIQUE (RFCCajero),
    ADD CONSTRAINT SalarioCajero_valido CHECK (SalarioCajero > 0),
    ALTER COLUMN IDSucursal SET NOT NULL,
    ALTER COLUMN RFCCajero SET NOT NULL,
    ALTER COLUMN NombreCajero SET NOT NULL,
    ALTER COLUMN ApellidoPaternoCajero SET NOT NULL,
    ALTER COLUMN ApellidoMaternoCajero SET NOT NULL,
    ALTER COLUMN FechaNacimientoCajero SET NOT NULL,
    ALTER COLUMN FechaContratacionCajero SET NOT NULL,
    ALTER COLUMN SalarioCajero SET NOT NULL,
    ALTER COLUMN EntradaCajero SET NOT NULL,
    ALTER COLUMN SalidaCajero SET NOT NULL;


-- 10# TELEFONO CAJERO
CREATE TABLE TelefonoCajero(
    CURPCajero CHAR(18),
    TelefonoCajero CHAR(10)    
);

ALTER TABLE TelefonoCajero 
    ADD CONSTRAINT TelefonoCajeroPK PRIMARY KEY (TelefonoCajero),
    ADD CONSTRAINT TelefonoCajeroFK FOREIGN KEY (CURPCajero)
        REFERENCES Cajero(CURPCajero),
    ALTER COLUMN TelefonoCajero SET NOT NULL,
    ALTER COLUMN CURPCajero SET NOT NULL;


-- 11# CORREO CAJERO
CREATE TABLE CorreoCajero(
    CURPCajero CHAR(18),
    TelefonoCajero CHAR(10)
);

ALTER TABLE CorreoCajero
    ADD CONSTRAINT CorreoCajeroPK PRIMARY KEY (CorreoCajero),
    ADD CONSTRAINT CorreoCajeroFK FOREIGN KEY (CURPCajero)
        REFERENCES Cajero(CURPCajero),
    ALTER COLUMN CorreoCajero SET NOT NULL,
    ALTER COLUMN CURPCajero SET NOT NULL;


-- 12# TECNICO
CREATE TABLE Tecnico(
    CURPTecnico CHAR(18),
    IDSucursal VARCHAR(4),
    RFCTecnico CHAR(13),
    NombreTecnico VARCHAR(50),
    ApellidoPaternoTecnico VARCHAR(50),
    ApellidoMaternoTecnico VARCHAR(50),
    FechaNacimientoTecnico DATE,
    FechaContratacionTecnico DATE,
    SalarioTecnico NUMERIC(12, 2),
    Especialidad VARCHAR(50),
);

ALTER TABLE Tecnico
    ADD CONSTRAINT TecnicoPK PRIMARY KEY (CURPTecnico),
    ADD CONSTRAINT TecnicoFK FOREIGN KEY (IDSucursal)
        REFERENCES Sucursal(IDSucursal),
    ADD CONSTRAINT RFCTecnico_unico UNIQUE (RFCTecnico),
    ADD CONSTRAINT SalarioTecnico_valido CHECK (SalarioTecnico > 0),
    ALTER COLUMN IDSucursal SET NOT NULL,
    ALTER COLUMN RFCTecnico SET NOT NULL,
    ALTER COLUMN NombreTecnico SET NOT NULL,
    ALTER COLUMN ApellidoPaternoTecnico SET NOT NULL,
    ALTER COLUMN ApellidoMaternoTecnico SET NOT NULL,
    ALTER COLUMN FechaNacimientoTecnico SET NOT NULL,
    ALTER COLUMN FechaContratacionTecnico SET NOT NULL,
    ALTER COLUMN Especialidad SET NOT NULL;


-- 13# TELEFONO TECNICO
CREATE TABLE TelefonoTecnico(
    CURPTecnico CHAR(18),
    TelefonoTecnico CHAR(10)
);


ALTER TABLE TelefonoTecnico
    ADD CONSTRAINT TelefonoTecnicoPK PRIMARY KEY (TelefonoTecnico),
    ADD CONSTRAINT TelefonoTecnicoFK FOREIGN KEY (CURPTecnico)
        REFERENCES Tecnico(CURPTecnico),
    ALTER COLUMN TelefonoTecnico SET NOT NULL,
    ALTER COLUMN CURPTecnico SET NOT NULL;


-- 14# CORREO TECNICO
CREATE TABLE CorreoTecnico(
    CURPTecnico CHAR(18),
    CorreoTecnico CHAR(50)
);


ALTER TABLE CorreoTecnico 
    ADD CONSTRAINT CorreoTecnicoPK PRIMARY KEY (CorreoTecnico),
    ADD CONSTRAINT CorreoTecnicoFK FOREIGN KEY (CURPTecnico)
        REFERENCES Tecnico(CURPTecnico),
    ALTER COLUMN CorreoTecnico SET NOT NULL,
    ALTER COLUMN CURPTecnico SET NOT NULL;


-- 15# CERTIFICACION
CREATE TABLE Certificacion(
    CURPTecnico CHAR(18),
    Certificacion VARCHAR(150)
);

ALTER TABLE Certificacion
    ADD CONSTRAINT CertificacionPK PRIMARY KEY (Certificacion),
    ADD CONSTRAINT CertificacionFK FOREIGN KEY (CURPTecnico)
        REFERENCES Tecnico(CURPTecnico),
    ALTER COLUMN Certificacion SET NOT NULL,
    ALTER COLUMN CURPTecnico SET NOT NULL;


-- 16# JUEGO
CREATE TABLE Juego(
	IDJuego INT ,
	Nombre VARCHAR(100) ,
	Costo INT ,
	TipoJuego VARCHAR(30) 
);

ALTER TABLE Juego	
	ADD CONSTRAINT Juego_PK PRIMARY KEY (IDJuego), --PRIMARY KEY
	ALTER COLUMN Nombre SET NOT NULL,
	ADD CONSTRAINT Nombre_Juego_Minimamente_Valido CHECK (TRIM(Nombre) <> ''),
	ALTER COLUMN Costo SET NOT NULL,
	ADD CONSTRAINT Costo_Juego_Valido CHECK (Costo >= 0 AND Costo % 10 = 0), 
	ALTER COLUMN TipoJuego SET NOT NULL, 
	ADD CONSTRAINT Tipo_Juego_Valido CHECK (TipoJuego IN ('Destreza','Disparos', 'Velocidad' , 'Ritmo'));


-- 17# MAQUINA
--NOTA
-- Antes de Máquina debe estar definida Sucursal y Juego 
CREATE TABLE Maquina(
	IDMaquina INT,
	IDSucursal INT,
	IDJuego INT ,
	EstadoMaquina VARCHAR(30) 
);

ALTER TABLE Maquina
	ADD CONSTRAINT Maquina_PK PRIMARY KEY (IDMaquina), --PRIMARY KEY
	ALTER COLUMN IDSucursal SET NOT NULL,
	ADD CONSTRAINT Maquina_FK01S FOREIGN KEY (IDSucursal) 
		REFERENCES Sucursal (IDSucursal), 
	ALTER COLUMN IDJuego SET NOT NULL,
	ADD CONSTRAINT Maquina_FK02J FOREIGN KEY (IDJuego) 
		REFERENCES Juego (IDJuego),
	ALTER COLUMN EstadoMaquina SET NOT NULL,
	ADD CONSTRAINT Estado_Maquina_Valido CHECK (EstadoMaquina IN ('Activo', 'FueraDeServicio', 'Mantenimiento'));


-- 18# PREMIO
CREATE TABLE Premio(
	IDPremio VARCHAR(4), 
	Nombre VARCHAR(100),
	RangoEdad VARCHAR(8),
	ValorAproximado NUMERIC(6,2)
);

ALTER TABLE Premio
	ADD CONSTRAINT Premio_PK PRIMARY KEY (IDPremio),
	ALTER COLUMN Nombre SET NOT NULL,
	ADD CONSTRAINT Nombre_Premio_Minimamente_Válido CHECK (TRIM(Nombre) <> ''),
	ALTER COLUMN RangoEdad SET NOT NULL,
	ADD CONSTRAINT Premio_Rango_Edad_Valido CHECK (RangoEdad IN ('Infantil', 'Juvenil', 'Adulto')),
	ALTER COLUMN ValorAproximado SET NOT NULL,
	ADD CONSTRAINT Premio_Valor_Valido CHECK (ValorAproximado >= 0);
	

-- 19# REGISTRO PARTIDA
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


-- 20# CANJE
-- NOTA
-- Antes de Canje debe estar Tarjeta y EncargadoPremios
CREATE TABLE Canje(
	IDCanjeo INT,
	NoTarjeta INT,
	CURPEncPremios CHAR(18),
	Fecha DATE ,
	Hora TIME 
);

ALTER TABLE Canje
	ADD CONSTRAINT Canje_PK PRIMARY KEY (IDCanjeo),
	ALTER COLUMN NoTarjeta SET NOT NULL,
	ADD CONSTRAINT Canje_FK01T FOREIGN KEY (NoTarjeta) 
		REFERENCES Tarjeta(NoTarjeta),
	ALTER COLUMN CURPEncPremios SET NOT NULL,
	ADD CONSTRAINT Canje_FK02E FOREIGN KEY (CURPEncPremios) 
	 	REFERENCES EncargadoPremios(CURPEncPremios), 
	ALTER COLUMN Fecha SET NOT NULL, 
	ALTER COLUMN Hora SET NOT NULL;

	
-- 21# RECARGA
-- NOTA
-- Antes de Canje debe estar Tarjeta y Cajero
CREATE TABLE Recarga(
	CURPCajero CHAR(18),
	NoTarjeta INT,
	Fecha DATE ,
	Hora TIME ,
	Monto MONEY ,
	MetodoAbono VARCHAR(14) 
);

ALTER TABLE Recarga
	ALTER COLUMN CURPCajero SET NOT NULL,
	ADD CONSTRAINT Recarga_FK01C FOREIGN KEY (CURPCajero) 
		REFERENCES Cajero(CURPCajero),
	ALTER COLUMN NoTarjeta SET NOT NULL,
	ADD CONSTRAINT Recarga_FK02T FOREIGN KEY (NoTarjeta) 
		REFERENCES Tarjeta(NoTarjeta),
	ALTER COLUMN Fecha SET NOT NULL,
	ALTER COLUMN Hora SET NOT NULL,
	ALTER COLUMN Monto SET NOT NULL,
	ADD CONSTRAINT Recarga_Monto_Valido CHECK (Monto >= 0 AND Monto % 10 = 0),
	ALTER COLUMN MetodoAbono SET NOT NULL,
	ADD CONSTRAINT Recarga_MetodoAbono_Valido CHECK ( MetodoAbono IN ('Efectivo', 'TarjetaDebito','TarjetaCredito', 'Paypal'));


-- 22# GUARDAR
-- NOTA
-- Antes de Guardar debe estar Sucursal y Premio.
CREATE TABLE Guardar (
    IDSucursal VARCHAR(4) NOT NULL,
    IDPremio VARCHAR(4) NOT NULL,
    CantidadInicial INT NOT NULL
);


-- 23# INCLUIR
-- NOTA
-- Antes de Inlcuir debe estar definido Premio y Canje.
CREATE TABLE Incluir(
	IDPremio INT,
	IDCanjeo INT,
	Cantidad INT
);

ALTER TABLE Incluir
	ALTER COLUMN IDPremio SET NOT NULL,
	ADD CONSTRAINT Incluir_FK01P FOREIGN KEY (IDPremio)
		REFERENCES Premio(IDPremio),
	ALTER COLUMN IDCanjeo SET NOT NULL,
	ADD CONSTRAINT Incluir_FK02C FOREIGN KEY (IDCanjeo)
		REFERENCES Premio(IDCanjeo),
	ALTER COLUMN Cantidad SET NOT NULL,
	ADD CONSTRAINT Incluir_Cantidad_Valida CHECK (Cantidad >= 1);
	
	






-- Restricciones:

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

----- Horario
ALTER TABLE Horario ADD CONSTRAINT Horario_PK PRIMARY KEY (IDSucursal, HorarioInicio, HorarioFinal);

-- Referencial

----- RegistroPartida
ALTER TABLE RegistroPartida ADD CONSTRAINT  RegistroPartida_FK01M
FOREIGN KEY (IDMaquina) REFERENCES Maquina(IDMaquina);
ALTER TABLE RegistroPartida ADD CONSTRAINT  RegistroPartida_FK02T
FOREIGN KEY (NoTarjeta) REFERENCES Tarjeta(NoTarjeta);

----- Horario
ALTER TABLE Horario ADD CONSTRAINT  Horario_FK01S
FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal);

----- Guardar
ALTER TABLE Guardar ADD CONSTRAINT Guardar_FK01S 
FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal);
ALTER TABLE Guardar ADD CONSTRAINT Guardar_FK02P 
FOREIGN KEY (IDPremio) REFERENCES Premio(IDPremio);


