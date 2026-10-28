--CREATE DATABASE puellaGames;


-- 1# SUCURSAL
CREATE TABLE Sucursal (
    IDSucursal INT ,
    Nombre VARCHAR(100),
    Telefono VARCHAR(15),
    Calle VARCHAR(150),
    NumInterior INT,
    NumExterior INT,
    Colonia VARCHAR(100),
    Estado VARCHAR(50)
);

ALTER TABLE Sucursal 
	ADD CONSTRAINT Sucursal_PK PRIMARY KEY (IDSucursal),
    ALTER COLUMN Nombre SET NOT NULL,
    ALTER COLUMN Telefono SET NOT NULL,
    ALTER COLUMN Calle SET NOT NULL,
    ALTER COLUMN NumExterior SET NOT NULL,
    -- NumInterior puede ser null en caso de que no tenga uno, la direccion de la sucursal
    ALTER COLUMN Colonia SET NOT NULL, 
    ALTER COLUMN Estado SET NOT NULL,
    ADD CONSTRAINT idSucursal_valido CHECK (IDSucursal >= 0),
    ADD CONSTRAINT sucursalNombre_valido CHECK (Nombre ~ '^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ \-]+$' AND LENGTH(TRIM(Nombre)) > 0),
    ADD CONSTRAINT sucursalTelefono_valido CHECK (Telefono ~ '^[0-9]{10,15}$'),
    ADD CONSTRAINT sucursalCalle_valido CHECK (LENGTH(TRIM(Calle)) > 0),
    ADD CONSTRAINT sucursalNumInterior_valido CHECK (NumInterior > 0),
    ADD CONSTRAINT sucursalNumEXterior_valido CHECK (NumExterior > 0),
	ADD CONSTRAINT sucursalColonia_valido CHECK (LENGTH(TRIM(Colonia)) > 0),
	ADD CONSTRAINT sucursalEstado_valido CHECK (LENGTH(TRIM(Estado)) > 0);


-- Ya debe de estar definida Sucursal antes de los Empleados.

-- 2# HORARIO
CREATE TABLE Horario (
    HorarioInicio TIME ,
    HorarioFinal TIME ,
    IDSucursal INT ,
    Dia VARCHAR(9) NOT NULL
);

ALTER TABLE Horario 
	ADD CONSTRAINT Horario_PK PRIMARY KEY (IDSucursal, HorarioInicio, HorarioFinal),
	ADD CONSTRAINT Horario_FK01S FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal),
	ADD CONSTRAINT HorarioDia_chk CHECK (Dia IN('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'));


-- 3# GERENTE
CREATE TABLE Gerente(
    CURPGerente CHAR(18),
    IDSucursal INT,
    RFCGerente CHAR(13),
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
    ALTER COLUMN CedulaProfesional SET NOT NULL,
	ADD CONSTRAINT gerenteNombre_valido CHECK (NombreGerente ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreGerente)) > 0),
	ADD CONSTRAINT gerenteApellidoP_valido CHECK (ApellidoPaternoGerente ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoGerente)) > 0),
	ADD CONSTRAINT gerenteApellidoM_valido CHECK (ApellidoMaternoGerente ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoGerente)) > 0),
	ADD CONSTRAINT gerenteCurp_valido CHECK (CURPGerente ~ '^[A-Z0-9]{18}$'),
	ADD CONSTRAINT RFCGerente_valido CHECK (RFCGerente ~ '^[A-Z0-9]{12,13}$'),
	ADD CONSTRAINT gerenteFNac_valido CHECK (FechaNacimientoGerente <= CURRENT_DATE),
	ADD CONSTRAINT gerenteFCont_valido CHECK (FechaContratacionGerente > FechaNacimientoGerente AND FechaContratacionGerente <= CURRENT_DATE);


-- 4# TELEFONO GERENTE
CREATE TABLE TelefonoGerente(
    CURPGerente CHAR(18),
    TelefonoGerente VARCHAR(10)
);

ALTER TABLE TelefonoGerente
    ADD CONSTRAINT TelefonoGerentePK PRIMARY KEY (TelefonoGerente),
    ADD CONSTRAINT TelefonoGerenteFK FOREIGN KEY (CURPGerente)
        REFERENCES Gerente(CURPGerente),
    ALTER COLUMN CURPGerente SET NOT NULL,
	ADD CONSTRAINT GerenteTelefono_valido CHECK (TelefonoGerente ~ '^[0-9]{10}$');


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
    ADD CONSTRAINT GerenteCorreo_chk CHECK (
        CorreoGerente ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );


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
    ALTER COLUMN EntradaEncPremios SET NOT NULL,
    ALTER COLUMN SalidaEncPremios SET NOT NULL,
	ADD CONSTRAINT EncPremiosNombre_valido CHECK (NombreEncPremios ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreEncPremios)) > 0),
	ADD CONSTRAINT EncPremiosApellidoP_valido CHECK (ApellidoPaternoEncPremios ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoEncPremios)) > 0),
	ADD CONSTRAINT EncPremiosApellidoM_valido CHECK (ApellidoMaternoEncPremios ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoEncPremios)) > 0),
	ADD CONSTRAINT encPremiosCurp_valido CHECK (CURPEncPremios ~ '^[A-Z0-9]{18}$'),
	ADD CONSTRAINT RFCEncPremios_valido CHECK (RFCEncPremios ~ '^[A-Z0-9]{12,13}$'),
	ADD CONSTRAINT encPremiosFNac_valido CHECK (FechaNacimientoEncPremios <= CURRENT_DATE),
	ADD CONSTRAINT encPremiosFCont_valido CHECK (FechaContratacionEncPremios > FechaNacimientoEncPremios AND FechaContratacionEncPremios <= CURRENT_DATE);


-- 7# TELEFONO ENCARGADO PREMIOS
CREATE TABLE TelefonoEncPremios(
    CURPEncPremios CHAR(18),
    TelefonoEncPremios VARCHAR(10)
);

ALTER TABLE TelefonoEncPremios
    ADD CONSTRAINT TelefonoEncPremiosPK PRIMARY KEY (TelefonoEncPremios),
    ADD CONSTRAINT TelefonoEncPremiosFK FOREIGN KEY (CURPEncPremios) REFERENCES EncargadoPremios(CURPEncPremios),
    ALTER COLUMN CURPEncPremios SET NOT NULL,
	ADD CONSTRAINT EncPremiosTelefono_valido CHECK (TelefonoEncPremios ~ '^[0-9]{10}$');


-- 8# CORREO ENCARGADO PREMIOS
CREATE TABLE CorreoEncPremios(
    CURPEncPremios CHAR(18),
    CorreoEncPremios VARCHAR(50)
);

ALTER TABLE CorreoEncPremios
    ADD CONSTRAINT CorreoEncPremiosPK PRIMARY KEY (CorreoEncPremios),
    ADD CONSTRAINT CorreoEncPremiosKF FOREIGN KEY (CURPEncPremios) REFERENCES EncargadoPremios(CURPEncPremios),
    ALTER COLUMN CURPEncPremios SET NOT NULL,
    ADD CONSTRAINT EncPremiosCorreo_chk CHECK (
        CorreoEncPremios ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );


-- 9# CAJERO
CREATE TABLE Cajero(
    CURPCajero CHAR(18),
    IDSucursal INT,
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
	ADD CONSTRAINT CajeroNombre_valido CHECK (NombreCajero ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreCajero)) > 0),
	ADD CONSTRAINT CajeroApellidoP_valido CHECK (ApellidoPaternoCajero ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoCajero)) > 0),
	ADD CONSTRAINT CajeroApellidoM_valido CHECK (ApellidoMaternoCajero ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoCajero)) > 0),
	ADD CONSTRAINT cajeroCurp_valido CHECK (CURPCajero ~ '^[A-Z0-9]{18}$'),
	ADD CONSTRAINT RFCCajero_valido CHECK (RFCCajero ~ '^[A-Z0-9]{12,13}$'),
	ADD CONSTRAINT cajeroFNac_valido CHECK (FechaNacimientoCajero <= CURRENT_DATE),
	ADD CONSTRAINT cajeroFCont_valido CHECK (FechaContratacionCajero > FechaNacimientoCajero AND FechaContratacionCajero <= CURRENT_DATE);


-- 10# TELEFONO CAJERO
CREATE TABLE TelefonoCajero(
    CURPCajero CHAR(18),
    TelefonoCajero VARCHAR(10)    
);

ALTER TABLE TelefonoCajero 
    ADD CONSTRAINT TelefonoCajeroPK PRIMARY KEY (TelefonoCajero),
    ADD CONSTRAINT TelefonoCajeroFK FOREIGN KEY (CURPCajero)
        REFERENCES Cajero(CURPCajero),
    ALTER COLUMN CURPCajero SET NOT NULL,
	ADD CONSTRAINT CajeroTelefono_valido CHECK (TelefonoCajero ~ '^[0-9]{10}$');


-- 11# CORREO CAJERO
CREATE TABLE CorreoCajero(
    CURPCajero CHAR(18),
    CorreoCajero CHAR(50)
);

ALTER TABLE CorreoCajero
    ADD CONSTRAINT CorreoCajeroPK PRIMARY KEY (CorreoCajero),
    ADD CONSTRAINT CorreoCajeroFK FOREIGN KEY (CURPCajero)
        REFERENCES Cajero(CURPCajero),
    ALTER COLUMN CorreoCajero SET NOT NULL,
    ALTER COLUMN CURPCajero SET NOT NULL,
    ADD CONSTRAINT CajeroCorreo_chk CHECK (
        CorreoCajero ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );


-- 12# TECNICO
CREATE TABLE Tecnico(
    CURPTecnico CHAR(18),
    IDSucursal INT,
    RFCTecnico CHAR(13),
    NombreTecnico VARCHAR(50),
    ApellidoPaternoTecnico VARCHAR(50),
    ApellidoMaternoTecnico VARCHAR(50),
    FechaNacimientoTecnico DATE,
    FechaContratacionTecnico DATE,
    SalarioTecnico NUMERIC(12, 2),
    Especialidad VARCHAR(50)
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
    ALTER COLUMN Especialidad SET NOT NULL,
    ADD CONSTRAINT TecnicoNombre_valido CHECK (NombreTecnico ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreTecnico)) > 0),
	ADD CONSTRAINT TecnicoApellidoP_valido CHECK (ApellidoPaternoTecnico ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoTecnico)) > 0),
	ADD CONSTRAINT TecnicoApellidoM_valido CHECK (ApellidoMaternoTecnico ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoTecnico)) > 0),
	ADD CONSTRAINT tecnicoCurp_valido CHECK (CURPTecnico ~ '^[A-Z0-9]{18}$'),
	ADD CONSTRAINT RFCTecnico_valido CHECK (RFCTecnico ~ '^[A-Z0-9]{12,13}$'),
	ADD CONSTRAINT tecnicoFNac_valido CHECK (FechaNacimientoTecnico <= CURRENT_DATE),
	ADD CONSTRAINT tecnicoFCont_valido CHECK (FechaContratacionTecnico > FechaNacimientoTecnico AND FechaContratacionTecnico <= CURRENT_DATE);


-- 13# TELEFONO TECNICO
CREATE TABLE TelefonoTecnico(
    CURPTecnico CHAR(18),
    TelefonoTecnico VARCHAR(10)
);


ALTER TABLE TelefonoTecnico
    ADD CONSTRAINT TelefonoTecnicoPK PRIMARY KEY (TelefonoTecnico),
    ADD CONSTRAINT TelefonoTecnicoFK FOREIGN KEY (CURPTecnico)
        REFERENCES Tecnico(CURPTecnico),
    ALTER COLUMN TelefonoTecnico SET NOT NULL,
    ALTER COLUMN CURPTecnico SET NOT NULL,
	ADD CONSTRAINT TecnicoTelefono_valido CHECK (TelefonoTecnico ~ '^[0-9]{10}$');


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
    ALTER COLUMN CURPTecnico SET NOT NULL,
    ADD CONSTRAINT TecnicoCorreo_chk CHECK (
        CorreoTecnico ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );


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



-- 16# CLIENTE
CREATE TABLE Cliente (
	IDCliente INT,
	Nombre VARCHAR(100),
	ApellidoP VARCHAR(100),
	ApellidoM VARCHAR(100),
	FechaNacimiento DATE
);

ALTER TABLE Cliente 
	ADD CONSTRAINT pk_cliente PRIMARY KEY (IDCliente),
	ALTER COLUMN Nombre SET NOT NULL,
	ALTER COLUMN ApellidoP SET NOT NULL, 
	ALTER COLUMN ApellidoM SET NOT NULL,
	ALTER COLUMN FechaNacimiento SET NOT NULL,
    ADD CONSTRAINT chk_fecha_nacimiento CHECK (
        FechaNacimiento >= '1909-01-01' AND 
        FechaNacimiento <= CURRENT_DATE - INTERVAL '12 years' -- Creo es la única instancia de esto. 
    ),-- Lo comento igual para ver. "12 years" es para que al menos 12 años desde hoy, ergo no sobre el año calendario
        -- sino sobre un intervalo de 1 año.
	ADD CONSTRAINT ClienteNombre_valido CHECK (Nombre ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(Nombre)) > 0),
	ADD CONSTRAINT ClienteApellidoP_valido CHECK (ApellidoP ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoP)) > 0),
	ADD CONSTRAINT ClienteApellidoM_valido CHECK (ApellidoM ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoM)) > 0);

    
 -- 17# TARJETA
CREATE TABLE Tarjeta (
    NoTarjeta INT
);

ALTER TABLE Tarjeta
	ADD CONSTRAINT Tarjeta_PK PRIMARY KEY (NoTarjeta);


 -- 18# PERTENECER
CREATE TABLE Pertenecer (
	IDCliente INT,
	NoTarjeta INT,
	Nombre VARCHAR(100),
	ApellidoP VARCHAR(100),
	ApellidoM VARCHAR(100),
	FechaNacimiento DATE
);

ALTER TABLE Pertenecer 
	ADD CONSTRAINT pk_pertenecer PRIMARY KEY (IDCliente, NoTarjeta), --SE AGREGAN COMO PRIMARY KEY PERO TAMBIEN COMO FOREIGN KEY.
	ADD CONSTRAINT fk_pertenecer_cliente FOREIGN KEY (IDCliente) 
		REFERENCES Cliente(IDCliente),
	ADD CONSTRAINT fk_pertenecer_tarjeta FOREIGN KEY (NoTarjeta) 
		REFERENCES Tarjeta(NoTarjeta),
	ALTER COLUMN Nombre SET NOT NULL,
	ALTER COLUMN ApellidoP SET NOT NULL,
	ALTER COLUMN ApellidoM SET NOT NULL,
	ALTER COLUMN FechaNacimiento SET NOT NULL,
    ADD CONSTRAINT chk_fecha_nacimiento CHECK (
        FechaNacimiento >= '1909-01-01' AND 
        FechaNacimiento <= CURRENT_DATE - INTERVAL '12 years'
    );
    
    
 -- 19# CORREO CLIENTE
CREATE TABLE CorreoCliente (
	IDCliente INT,
	CorreoCliente VARCHAR(76)
);

ALTER TABLE CorreoCliente
	ADD CONSTRAINT pk_correocliente PRIMARY KEY (IDCliente, CorreoCliente), 
	ADD CONSTRAINT fk_correocliente_cliente FOREIGN KEY (IDCliente) 
		REFERENCES Cliente(IDCliente),
    ADD CONSTRAINT chk_correo_formato CHECK (
        CorreoCliente ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );-- Uno supondría que aquí debería discutirse. 
    -- "string de al menos un caracter sin @" + "@" + "string de al menos un caracter sin @" + "$" (fin de cadena)
       
    
 -- 20# TELEFONO CLIENTE
CREATE TABLE TelefonoCliente (
	IDCliente INT,
	TelefonoCliente VARCHAR(10)
);

ALTER TABLE TelefonoCliente
	ADD CONSTRAINT pk_telefonocliente PRIMARY KEY (IDCliente, TelefonoCliente), --SE AGREGAN COMO PRIMARY KEY PERO TAMBIEN COMO FOREIGN KEY.
	ADD CONSTRAINT fk_telefonocliente_cliente FOREIGN KEY (IDCliente) 
		REFERENCES Cliente(IDCliente),
    ADD CONSTRAINT chk_telefono_formato CHECK (TelefonoCliente ~ '^[0-9]{10}$'); 


-- 21# JUEGO
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


-- 22# MAQUINA
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


-- 23# PREMIO
CREATE TABLE Premio(
	IDPremio INT, 
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
	ADD CONSTRAINT Premio_Valor_Valido CHECK (ValorAproximado >= 0 AND ValorAproximado < 10000);
	

-- 24# REGISTRO PARTIDA

CREATE TABLE RegistroPartida(
	IDRegistro INT,
	IDMaquina INT NOT NULL UNIQUE,
	NoTarjeta INT NOT NULL UNIQUE,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL,	
	Puntuacion INT NOT NULL
);	

ALTER TABLE RegistroPartida 
	ADD CONSTRAINT RegistroPartida_PK PRIMARY KEY (IDRegistro),
	ADD CONSTRAINT  RegistroPartida_FK01M FOREIGN KEY (IDMaquina) REFERENCES Maquina(IDMaquina),
	ADD CONSTRAINT  RegistroPartida_FK02T FOREIGN KEY (NoTarjeta) REFERENCES Tarjeta(NoTarjeta),
	ADD CONSTRAINT RegistroPartida_DOM01 CHECK (Puntuacion >= 0),
	ADD CONSTRAINT RegistroPartida_DOM02 CHECK (Fecha <= CURRENT_DATE);


-- 25# CANJE
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

	
-- 26# RECARGA
-- NOTA
-- Antes de Canje debe estar Tarjeta y Cajero
CREATE TABLE Recarga(
	CURPCajero CHAR(18),
	NoTarjeta INT,
	Fecha DATE ,
	Hora TIME ,
	Monto INT,
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


-- 27# GUARDAR
-- NOTA
-- Antes de Guardar debe estar Sucursal y Premio.
CREATE TABLE Guardar (
    IDSucursal INT,
    IDPremio INT,
    CantidadInicial INT
);

ALTER TABLE Guardar 
	ALTER COLUMN IDSucursal SET NOT NULL,
	ALTER COLUMN IDPremio SET NOT NULL,
	ALTER COLUMN CantidadInicial SET NOT NULL,
	ADD CONSTRAINT Guardar_FK01S FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal),
	ADD CONSTRAINT Guardar_FK02P FOREIGN KEY (IDPremio) REFERENCES Premio(IDPremio),
	ADD CONSTRAINT Guardar_DOM01 CHECK (CantidadInicial >= 0);


-- 28# INCLUIR
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
		REFERENCES Canje(IDCanjeo),
	ALTER COLUMN Cantidad SET NOT NULL,
	ADD CONSTRAINT Incluir_Cantidad_Valida CHECK (Cantidad >= 1);

-- 29# MANTENIMIENTO
CREATE TABLE Mantenimiento(
	IDMantenimiento INT,
	CURPTecnico CHAR(18),
	IDMaquina INT,
	Hora TIME,
	Fecha DATE,
	TipoMantenimiento VARCHAR(30),
	Descripcion VARCHAR(300)
);
	
ALTER TABLE Mantenimiento
	ADD CONSTRAINT Mantenimiento_PK PRIMARY KEY (IDMantenimiento),
	ALTER COLUMN CURPTecnico SET NOT NULL,
	ADD CONSTRAINT Mantenimiento_FK01C FOREIGN KEY (CURPTecnico)
		REFERENCES Tecnico(CURPTecnico),
	ALTER COLUMN IDMaquina SET NOT NULL,
	ADD CONSTRAINT Mantenimiento_FK02I FOREIGN KEY (IDMaquina)
		REFERENCES Maquina(IDMaquina),
    ALTER COLUMN Hora SET NOT NULL,
    ALTER COLUMN Fecha SET NOT NULL,
    ALTER COLUMN TipoMantenimiento SET NOT NULL,
    ALTER COLUMN Descripcion SET NOT NULL,
    ADD CONSTRAINT idMantenimiento_valido CHECK (IDMantenimiento >= 0);



