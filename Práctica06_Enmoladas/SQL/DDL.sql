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

-- Comentarios
COMMENT ON TABLE Sucursal IS 'Tabla que representa a la Sucursal';

COMMENT ON COLUMN Sucursal.IDSucursal IS 'Identificador de la Sucursal';
COMMENT ON COLUMN Sucursal.Nombre IS 'Nombre de la sucursal';
COMMENT ON COLUMN Sucursal.Telefono IS 'Telefono de la sucursal';
COMMENT ON COLUMN Sucursal.Calle IS 'Calle donde esta ubicada la Sucursal';
COMMENT ON COLUMN Sucursal.NumInterior IS 'Numero Interior donde esta ubicada la Sucursal';
COMMENT ON COLUMN Sucursal.NumExterior IS 'Numero Exterior donde esta ubicada la Sucursal';
COMMENT ON COLUMN Sucursal.Colonia IS 'Colonia donde esta ubicada la Sucursal';
COMMENT ON COLUMN Sucursal.Estado IS 'Estado donde esta ubicada la Sucursal';

COMMENT ON CONSTRAINT Sucursal_PK ON Sucursal IS 'Restriccion de Entidad para la tabla Sucursal';

COMMENT ON CONSTRAINT idSucursal_valido ON Sucursal IS 'Restriccion de dominio para el atributo IDSucursal de la tabla Sucursal, tal que sea un numero mayor o igual a 0';
COMMENT ON CONSTRAINT sucursalNombre_valido ON Sucursal IS 'Restriccion de dominio para el atributo Nombre de la tabla Sucursal, tal que estee formado por letras, espacios y guiones ademas de no estar vacio';
COMMENT ON CONSTRAINT sucursalTelefono_valido ON Sucursal IS 'Restriccion de dominio para el atributo Telefono de la tabla Sucursal, tal que estee formado unicamente por numeros y tenga una longitud de entre 10 y 15 digitos';
COMMENT ON CONSTRAINT sucursalCalle_valido ON Sucursal IS 'Restriccion de dominio para el atributo Calle de la tabla Sucursal, tal que estee formado por letras, espacios y guiones ademas de no estar vacio';
COMMENT ON CONSTRAINT sucursalNumInterior_valido ON Sucursal IS 'Restriccion de dominio para el atributo NumInterior de la tabla Sucursal, tal que sea un numero mayor o igual a 0';
COMMENT ON CONSTRAINT sucursalNumEXterior_valido ON Sucursal IS 'Restriccion de dominio para el atributo NumExterior de la tabla Sucursal, tal que sea un numero mayor o igual a 0';
COMMENT ON CONSTRAINT sucursalColonia_valido ON Sucursal IS 'Restriccion de dominio para el atributo Colonia de la tabla Sucursal, tal que no este vacio ni formado por solo espacios';
COMMENT ON CONSTRAINT sucursalEstado_valido ON Sucursal IS 'Restriccion de dominio para el atributo Estado de la tabla Sucursal, tal que no este vacio ni formado por solo espacios';


-- Ya debe de estar definida Sucursal antes de los Empleados.

-- 2# HORARIO
CREATE TABLE Horario (
    HorarioInicio TIME ,
    HorarioFinal TIME ,
    IDSucursal INT ,
    Dia VARCHAR(9)
);

ALTER TABLE Horario 
	ADD CONSTRAINT Horario_PK PRIMARY KEY (IDSucursal, HorarioInicio, HorarioFinal, Dia),
	ADD CONSTRAINT Horario_FK01S FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal)
		ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT HorarioDia_chk CHECK (Dia IN('Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'));

-- Comentarios
COMMENT ON TABLE Horario IS 'Tabla que representa al Horario de cada Sucursal';

COMMENT ON COLUMN Horario.HorarioInicio IS 'Horario Inicial que abre la Sucursal';
COMMENT ON COLUMN Horario.HorarioFinal IS 'Horario Final de cierre de la Sucursal';
COMMENT ON COLUMN Horario.IDSucursal IS 'ID de la sucursal a la que pertenece el horario';
COMMENT ON COLUMN Horario.Dia IS 'Dia de la semana al que pertenece el horario';

COMMENT ON CONSTRAINT Horario_PK ON Horario IS 'Restriccion de Entidad para la tabla Horario';
COMMENT ON CONSTRAINT Horario_FK01S ON Horario IS 'Restriccion de integridad referencial para la tabla Horario';

COMMENT ON CONSTRAINT HorarioDia_chk ON Horario IS 'Restriccion de dominio para el atributo Dia de la tabla Horario, tal que solo se acepten dias de la semana';



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
    ADD CONSTRAINT GerenteCurp_valido CHECK (CURPGerente ~ '^[A-Z0-9]{18}$'),
    ADD CONSTRAINT GerenteFK FOREIGN KEY (IDSucursal) 
        REFERENCES Sucursal(IDSucursal)
        ON DELETE CASCADE,
    ADD CONSTRAINT RFCGerente_unico UNIQUE (RFCGerente),
    ADD CONSTRAINT RFCGerente_valido CHECK (RFCGerente ~ '^[A-ZÑ0-9]{12,13}$'),
    ADD CONSTRAINT GerenteNombre_valido CHECK (NombreGerente ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreGerente)) > 0),
    ADD CONSTRAINT GerenteApellidoP_valido CHECK (ApellidoPaternoGerente ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoGerente)) > 0),
    ADD CONSTRAINT GerenteApellidoM_valido CHECK (ApellidoMaternoGerente ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoGerente)) > 0),
    ADD CONSTRAINT GerenteFechaCont_valido CHECK (FechaContratacionGerente > FechaNacimientoGerente),
    ADD CONSTRAINT SalarioGerente_valido CHECK (SalarioGerente > 0),
    ADD CONSTRAINT CedulaGerente_unico UNIQUE (CedulaProfesional),
    ADD CONSTRAINT CedulaGerente_valido CHECK (CedulaProfesional ~ '^[0-9]{6,8}$')
    ALTER COLUMN IDSucursal SET NOT NULL,
    ALTER COLUMN RFCGerente SET NOT NULL,
    ALTER COLUMN NombreGerente SET NOT NULL,
    ALTER COLUMN ApellidoPaternoGerente SET NOT NULL,
    ALTER COLUMN ApellidoMaternoGerente SET NOT NULL,
    ALTER COLUMN FechaContratacionGerente SET NOT NULL,
    ALTER COLUMN FechaNacimientoGerente SET NOT NULL,
    ALTER COLUMN SalarioGerente SET NOT NULL,
    ALTER COLUMN CedulaProfesional SET NOT NULL;

-- Comentarios

COMMENT ON TABLE Gerente IS 'Tabla que representa a los Gerentes';

COMMENT ON COLUMN Gerente.CURPGerente IS 'Curp del Gerente';
COMMENT ON COLUMN Gerente.IDSucursal IS 'Identificador unico de la Sucursal en la que trabaja el Gerente';
COMMENT ON COLUMN Gerente.RFCGerente IS 'RFC del Gerente';
COMMENT ON COLUMN Gerente.NombreGerente IS 'Nombre de pila del Gerente';
COMMENT ON COLUMN Gerente.ApellidoPaternoGerente IS 'Apellido paterno del Gerente';
COMMENT ON COLUMN Gerente.ApellidoMaternoGerente IS 'Apellido materno del Gerente';
COMMENT ON COLUMN Gerente.FechaContratacionGerente IS 'Fecha de contratación del Gerente';
COMMENT ON COLUMN Gerente.FechaNacimientoGerente IS 'Fecha de nacimiento del Gerente';
COMMENT ON COLUMN Gerente.SalarioGerente IS 'Salario del Gerente';
COMMENT ON COLUMN Gerente.CedulaProfesional IS 'Cedula profesional del Gerente';

COMMENT ON CONSTRAINT GerentePK IS 'Restricción de Entidad para la tabla Gerente';
COMMENT ON CONSTRAINT GerenteCurp_valido IS 'Restricción de Dominio para el atributo CURPGerente de la tabla Gerente. Nos asegura que solo contenga letras mayusculas, números, y que su longitud sea de 18 caracteres';
COMMENT ON CONSTRAINT GerenteFK IS 'Restricción de Integridad referencial para la tabla Gerente';
COMMENT ON CONSTRAINT RFCGerente_unico IS 'Restricción de Dominio para el atributo RFCGerente de la tabla Gerente. No se pueden repetir los RFC ya que son unicos'
COMMENT ON CONSTRAINT RFCGerente_valido IS 'Restricción de Dominio para el atributo RFCGerente de la tabla Gerente. Nos asegura que no este formado por espacios blancos y con letras mayusculas sin caracteres especiales';
COMMENT ON CONSTRAINT GerenteNombre_valido IS 'Restricción de Dominio para el atributo NombreGerente de la tabla Gerente. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las letras asentuadas son permitidas';
COMMENT ON CONSTRAINT GerenteApellidoP_valido IS 'Restricción de Dominio para el atributo ApellidoPaternoGerente de la tabla Gerente. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las letras asentuadas son permitidas';
COMMENT ON CONSTRAINT GerenteApellidoM_valido IS 'Restricción de Dominio para el atributo ApellidoMaternoGerente de la tabla Gerente. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las letras asentuadas son permitidas';
COMMENT ON CONSTRAINT GerenteFechaCont_valido IS 'Restricción de Dominio para el atributo FechaContrataciónGerente de la tabla Gerente. Nos asegura que la fecha de contratación sea despues de la fecha de nacimiento';
COMMENT ON CONSTRAINT SalarioGerente_valido IS 'Restricción de Dominio para el atributo SalarioGerente de la tabla Gerente. Nos asegura que el salario sea un número positivo';
COMMENT ON CONSTRAINT CedulaGerente_unico IS 'Restricción de dominio para el atributo CedulaProfesional de la tabla Gerente. Nos asegura que la cédula no se repita entre empleados';
COMMENT ON CONSTRAINT CedulaGerente_valido IS 'Restricción de dominio para el atributo CedulaProfesional de la tabla Gerente. Nos asegura que solo contenga números con longitud entre 6 y 8 caracteres';


-- 4# TELEFONO GERENTE
CREATE TABLE TelefonoGerente(
    CURPGerente CHAR(18),
    TelefonoGerente CHAR(10)
);

ALTER TABLE TelefonoGerente
    ADD CONSTRAINT TelefonoGerentePK PRIMARY KEY (CURPGerente, TelefonoGerente),
    ADD CONSTRAINT TelefonoGerenteFK FOREIGN KEY (CURPGerente)
        REFERENCES Gerente(CURPGerente)
        ON DELETE CASCADE,
	ADD CONSTRAINT GerenteTelefono_valido CHECK (TelefonoGerente ~ '^[0-9]{10}$');

-- Comentarios

COMMENT ON TABLE TelefonoGerente IS 'Tabla que representa los numeros de Teléfono de los gerentes';

COMMENT ON COLUMN TelefonoGerente.TelefonoGerente IS 'Número de Telefono del Gerente';
COMMENT ON COLUMN TelefonoGerente.CURPGerente IS 'CURP del Gerente al que está asociado el número de Teléfono';

COMMENT ON CONSTRAINT TelefonoGerentePK IS 'Restricción de Entidad para la tabla TelefonoGerente';
COMMENT ON CONSTRAINT TelefonoCajeroFK IS 'Restricción de Integridad referencial para la tabla TelefonoGerente';
COMMENT ON CONSTRAINT GerenteTelefono_valido IS 'Restricción de dominio para el atributo TelefonoGerente de la tabla TelefonoGerente. Nos asegura que solo contenga números del 0 al 9 como caracteres';


-- 5# CORREO GERENTE
CREATE TABLE CorreoGerente(
    CURPGerente CHAR(18),
    CorreoGerente VARCHAR(50)
);

ALTER TABLE CorreoGerente
    ADD CONSTRAINT CorreoGerentePK PRIMARY KEY (CURPGerente, CorreoGerente),
    ADD CONSTRAINT CorreoGerenteFK FOREIGN KEY (CURPGerente)
        REFERENCES Gerente(CURPGerente)
        ON DELETE CASCADE,
    ADD CONSTRAINT GerenteCorreo_valido CHECK (
        CorreoGerente ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );

-- Comentarios

COMMENT ON TABLE CorreoGerente IS 'Tabla que representa los Correos electronicos de los gerentes';

COMMENT ON COLUMN CorreoGerente.CorreoGerente IS 'Correo del Gerente';
COMMENT ON COLUMN CorreoGerente.CURPGerente IS 'CURP del Gerente al que está asociado el Correo electronico';

COMMENT ON CONSTRAINT CorreoGerentePK IS 'Restricción de Entidad para la tabla CorreoGerente';
COMMENT ON CONSTRAINT CorreoGerenteFK IS 'Restricción de Integridad referencial para la tabla CorreoGerente';
COMMENT ON CONSTRAINT GerenteCorreo_valido IS 'Restricción de Dominio para el atributo CorreoGerente de la tabla CorreoGerente. Nos asegura que la dirección de correo sea valida al incluir caracteres especiales más el separador @ para el dominio del correo';


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
    ADD CONSTRAINT EncPremiosCurp_valido CHECK (CURPEncPremios ~ '^[A-Z0-9]{18}$'),
    ADD CONSTRAINT EncPremiosFK FOREIGN KEY (IDSucursal)
        REFERENCES Sucursal(IDSucursal)
        ON DELETE CASCADE,
    ADD CONSTRAINT RFCEncPremios_unico UNIQUE (RFCEncPremios),
    ADD CONSTRAINT RFCEncPremios_valido CHECK (RFCEncPremios ~ '^[A-ZÑ0-9]{12,13}$'),
    ADD CONSTRAINT EncPremiosNombre_valido CHECK (NombreEncPremios ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreEncPremios)) > 0),
	ADD CONSTRAINT EncPremiosApellidoP_valido CHECK (ApellidoPaternoEncPremios ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoEncPremios)) > 0),
	ADD CONSTRAINT EncPremiosApellidoM_valido CHECK (ApellidoMaternoEncPremios ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoEncPremios)) > 0),
    ADD CONSTRAINT EncPremiosFechaCont_valido CHECK (FechaContratacionEncPremios > FechaNacimientoEncPremios),
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
    ALTER COLUMN SalidaEncPremios SET NOT NULL;

-- Comentarios

COMMENT ON TABLE EncargadoPremios IS 'Tabla que representa a los Encargados de los Premios';

COMMENT ON COLUMN EncargadoPremios.CURPEncPremios IS 'CURP del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.IDSucursal IS 'Identificador unico de la Sucursal en la que trabaja el Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.RFCEncPremios IS 'RFC del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.NombreEncPremios IS 'Nombre de pila del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.ApellidoPaternoEncPremios IS 'Apellido paterno del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.ApellidoMaternoEncPremios IS 'Apellido materno del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.FechaNacimientoEncPremios IS 'Fecha de nacimiento del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.FechaContratacionEncPremios IS 'Fecha de contratación del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.SalarioEncPremios IS 'Salario del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.EntradaEncPremios IS 'Hora de entrada del Encargado de Premios';
COMMENT ON COLUMN EncargadoPremios.SalidaEncPremios IS 'Hora de salida del Encargado Premios';

COMMENT ON CONSTRAINT EncPremiosPK IS 'Restricción de Entidad para la tabla EncargadoPremios';
COMMENT ON CONSTRAINT EncPremiosCurp_valido IS 'Restricción de Dominio para el atributo CURPEncPremios de la tabla EncargadoPremios. Nos asegura que solo contenga letras mayusculas y números con una longitud de 18 en sus caracteres';
COMMENT ON CONSTRAINT EncPremiosFK IS 'Restricción de Integridad referencial para la tabla EncargadoPremios';
COMMENT ON CONSTRAINT RFCEncPremios_unico IS 'Restricción de Dominio para el atributo RFCEncPremios de la tabla EncargadoPremios. No se pueden repetir los RFC ya que son únicos';
COMMENT ON CONSTRAINT RFCEncPremios_valido IS 'Restricción de Dominio para el atributo RFCEncPremios de la tabla EncargadoPremios. Nos asegura que solo contenga letras mayusculas, numeros, y que tenga una longitud de 12 a 13 caracteres';
COMMENT ON CONSTRAINT EncPremiosNombre_valido IS 'Restricción de Dominio para el atributo NombreEncPremios de la tabla EncargadoPremios. Nos asegura que no este formado por espacios en blanco ni que contenga caracteres especiales, las letras asentuadas estan permitidas';
COMMENT ON CONSTRAINT EncPremiosApellidoP_valido IS 'Restricción de Dominio para el atributo ApellidoPaternoEncPremios de la tabla EncargadoPremios. Nos asegura que no este formado por espacios en blanco ni que contenga caracteres especiales, las letras asentuadas estan permitidas';
COMMENT ON CONSTRAINT EncPremiosApellidoM_valido IS 'Restricción de Dominio para el atributo ApellidoMaternoEncPremios de la tabla EncargadoPremios. Nos asegura que no este formado por espacios en blanco ni que contenga caracteres especiales, las letras asentuadas estan permitidas';
COMMENT ON CONSTRAINT EncPremiosFechaCont_valido IS 'Restricción de Dominio para el atributo FechaContraracionEncPremios de la tabla EncagradoPremios. Nos asegura que la fecha de contratación sea despues de la fecha de nacimiento';
COMMENT ON CONSTRAINT SalarioEncPremios_valido IS 'Restricción de Dominio para el atributo SalarioEncPremios de la tabla EncargadoPremios. Nos asegura que el salario sea un número positivo';


-- 7# TELEFONO ENCARGADO PREMIOS
CREATE TABLE TelefonoEncPremios(
    CURPEncPremios CHAR(18),
    TelefonoEncPremios CHAR(10)
);

ALTER TABLE TelefonoEncPremios
    ADD CONSTRAINT TelefonoEncPremiosPK PRIMARY KEY (CURPEncPremios, TelefonoEncPremios),
    ADD CONSTRAINT TelefonoEncPremiosFK FOREIGN KEY (CURPEncPremios) 
        REFERENCES EncargadoPremios(CURPEncPremios)
        ON DELETE CASCADE,
	ADD CONSTRAINT EncPremiosTelefono_valido CHECK (TelefonoEncPremios ~ '^[0-9]{10}$');

-- Comentarios

COMMENT ON TABLE TelefonoEncPremios IS 'Tabla que representa los números de Teléfono de los Encargados de Premios';

COMMENT ON COLUMN TelefonoEncPremios.TelefonoEncPremios IS 'Número de Teléfono del Encargado de Premios';
COMMENT ON COLUMN TelefonoEncPremios.CURPEncPremios IS 'CURP del Encargado de Premios al que está asociado el número de Telefono';

COMMENT ON CONSTRAINT TelefonoEncPremiosPK IS 'Restricción de Entidad para la tabla TelefonoEncPremios';
COMMENT ON CONSTRAINT TelefonoEncPremiosFK IS 'Restricción de Integridad referencial para la tabla TelefonoEncPremios';
COMMENT ON CONSTRAINT EncPremiosTelefono_valido IS 'Restricción de Dominio para el atributo TelefonoEncPremios de la tabla TelefonoEncPremios. Nos asegura que solo contenga los números del 0 al 9 y cuya longitud de sus caracteres sea 10';

-- 8# CORREO ENCARGADO PREMIOS
CREATE TABLE CorreoEncPremios(
    CURPEncPremios CHAR(18),
    CorreoEncPremios VARCHAR(50)
);

ALTER TABLE CorreoEncPremios
    ADD CONSTRAINT CorreoEncPremiosPK PRIMARY KEY (CURPEncPremios,  CorreoEncPremios),
    ADD CONSTRAINT CorreoEncPremiosFK FOREIGN KEY (CURPEncPremios) 
        REFERENCES EncargadoPremios(CURPEncPremios)
        ON DELETE CASCADE,
    ADD CONSTRAINT EncPremiosCorreo_valido CHECK (CorreoEncPremios ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

-- Comentarios

COMMENT ON TABLE CorreoEncPremios IS 'Tabla que representa los Correos electronicos de los Encargados de Premios';

COMMENT ON COLUMN CorreoEncPremios.CorreoEncPremios IS 'Correo del Encargado de Premios';
COMMENT ON COLUMN CorreoEncPremios.CURPEncPremios IS 'CURP del Encargado de Premios al que está asociado el Correo electronico';

COMMENT ON CONSTRAINT CorreoEncPremiosPK IS 'Restricción de Entidad para la tabla CorreoEncPremios';
COMMENT ON CONSTRAINT CorreoEncPremiosFK IS 'Restricción de Integridad referencial para la tabla CorreoEncPremios';
COMMENT ON CONSTRAINT EncPremiosCorreo_valido IS 'Restricción de Dominio para el atributo CorreoEncPremios de la tabla CorreoEncPremios. Nos asegura que la dirección de correo electronico sea válida al incluir caracteres especiales mas el separador @ para el dominio del correo';


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
    ADD CONSTRAINT CajeroCurp_valido CHECK (CURPCajero ~ '^[A-Z0-9]{18}$'),
    ADD CONSTRAINT CajeroFK FOREIGN KEY (IDSucursal)
        REFERENCES Sucursal(IDSucursal)
        ON DELETE CASCADE,
    ADD CONSTRAINT RFCCajero_unico UNIQUE (RFCCajero),
    ADD CONSTRAINT RFCCajero_valido CHECK (RFCCajero ~ '^[A-ZÑ0-9]{12,13}$'),
    ADD CONSTRAINT CajeroNombre_valido CHECK (NombreCajero ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreCajero)) > 0),
	ADD CONSTRAINT CajeroApellidoP_valido CHECK (ApellidoPaternoCajero ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoCajero)) > 0),
	ADD CONSTRAINT CajeroApellidoM_valido CHECK (ApellidoMaternoCajero ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoCajero)) > 0),
    ADD CONSTRAINT CajeroFechaCont_valido CHECK (FechaContratacionCajero > FechaNacimientoCajero),
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

-- Comentarios

COMMENT ON TABLE Cajero IS 'Tabla que representa a los Cajeros'

COMMENT ON COLUMN Cajero.CURPCajero IS 'CURP del Cajero';
COMMENT ON COLUMN Cajero.IDSucursal IS 'Identificador unico de la Sucursal donde trabaja el Cajero';
COMMENT ON COLUMN Cajero.RFCCajero IS 'CURP del Cajero';
COMMENT ON COLUMN Cajero.NombreCajero IS 'Nombre de pila del Cajero';
COMMENT ON COLUMN Cajero.ApellidoPaternoCajero IS 'Apellido paterno del Cajero';
COMMENT ON COLUMN Cajero.ApellidoMaternoCajero IS 'Apellido materno del Cajero';
COMMENT ON COLUMN Cajero.FechaNacimientoCajero IS 'Fecha de nacimiento del Cajero';
COMMENT ON COLUMN Cajero.FechaContratacionCajero IS 'Fecha de contratación del Cajero';
COMMENT ON COLUMN Cajero.SalarioCajero IS 'Salario del Cajero';
COMMENT ON COLUMN Cajero.EntradaCajero IS 'Hora de entrada del Cajero';
COMMENT ON COLUMN Cajero.SalidaCajero IS 'Hora de salida del Cajero.';

COMMENT ON CONSTRAINT CajeroPK IS 'Restricción de Entidad para la tabla Cajero';
COMMENT ON CONSTRAINT CajeroCurp_valido IS 'Restricción de Dominio para el atributo CURPCajero de la tabla Cajero. Nos asegura que solo contenga letras mayusculas y números, ademas que la longitud total sea de 18 caracteres';
COMMENT ON CONSTRAINT CajeroFK IS 'Restricción de Integridad referencial para la tabla Cajero';
COMMENT ON CONSTRAINT RFCCajero_unico IS 'Restricción de Dominio para el atributo RFCCajero de la tabla Cajero. No se pueden repetir los RFC ya que son unicos';
COMMENT ON CONSTRAINT RFCCajero_valido IS 'Restricción de Dominio para el atributo RFCCajero de la tabla Cajero. Nos asgeura que solo contenga letras mayusculas, números, y que la longitud total sea de 12 a 13 caracteres'
COMMENT ON CONSTRAINT CajeroNombre_valido IS 'Restricción de Dominio para el atributo NombreCajero de la tabla Cajero. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las vocales asentuadas estan permitidas';
COMMENT ON CONSTRAINT CajeroApellidoP_valido IS 'Restricción de Dominio para el atributo ApellidoPaternoCajero de la tabla Cajero. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las vocales asentuadas estan permitidas';
COMMENT ON CONSTRAINT CajeroApellidoM_valido IS 'Restricción de Dominio para el atributo ApellidoMaternoCajero de la tabla Cajero. Nos asegura que no este formado por espacios en blanco ni que contenga caracteres especiales, las vocales asentuadas estan permitidas';
COMMENT ON CONSTRAINT CajeroFechaCont_valido IS 'Restricción de Dominio para el atributo FechaContratacionCajero de la tabla Cajero. Nos asegura que la fecha de contratación sea despues de la fecha de nacimiento';
COMMENT ON CONSTRAINT SalarioCajero_valido IS 'Restricción de Dominio para el atributo SalarioCajero de la tabla Cajero. Nos asegura que el salario sea un número positivo';


-- 10# TELEFONO CAJERO
CREATE TABLE TelefonoCajero(
    CURPCajero CHAR(18),
    TelefonoCajero CHAR(10)    
);

ALTER TABLE TelefonoCajero 
    ADD CONSTRAINT TelefonoCajeroPK PRIMARY KEY (CURPCajero, TelefonoCajero),
    ADD CONSTRAINT TelefonoCajeroFK FOREIGN KEY (CURPCajero)
        REFERENCES Cajero(CURPCajero)
        ON DELETE CASCADE,
	ADD CONSTRAINT CajeroTelefono_valido CHECK (TelefonoCajero ~ '^[0-9]{10}$');

-- Comentarios

COMMENT ON TABLE TelefonoCajero IS 'Tabla que representa los números de Teléfono de los Cajeros';

COMMENT ON COLUMN TelefonoCajero.TelefonoCajero IS 'Número de Teléfono del Cajero';
COMMENT ON COLUMN TelefonoCajero.CURPCajero IS 'CURP del Cajero al que está asociado el número de Teléfono';

COMMENT ON CONSTRAINT TelefonoCajeroPK IS 'Restricción de Entidad de la tabla TelefonoCajero';
COMMENT ON CONSTRAINT TelefonoCajeroFK IS 'Restricción de Integridad referencial de la tabla TelefonoCajero';
COMMENT ON CONSTRAINT CajeroTelefono_valido IS 'Restricción de Dominio para el atributo de TelefonoCajero de la tabla TelefonoCajero. Nos asegura que solo contenga los números del 0 al 9 y que su longitud total sea de 10 caracteres';


-- 11# CORREO CAJERO
CREATE TABLE CorreoCajero(
    CURPCajero CHAR(18),
    CorreoCajero VARCHAR(50)
);

ALTER TABLE CorreoCajero
    ADD CONSTRAINT CorreoCajeroPK PRIMARY KEY (CURPCajero, CorreoCajero),
    ADD CONSTRAINT CorreoCajeroFK FOREIGN KEY (CURPCajero)
        REFERENCES Cajero(CURPCajero)
        ON DELETE CASCADE,
    ADD CONSTRAINT CajeroCorreo_valido CHECK (
        CorreoCajero ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );

-- Comentarios

COMMENT ON TABLE CorreoCajero IS 'Tabla que representa los Correos electronicos de los Cajeros';

COMMENT ON COLUMN CorreoCajero.CorreoCajero IS 'Correo electronico del Cajero';
COMMENT ON COLUMN CorreoCajero.CURPCajero IS 'CURP del Cajero al que está asociado el Correo electronico';

COMMENT ON CONSTRAINT CorreoCajeroPK IS 'Restricción de Entidad para la tabla CorreoCajero';
COMMENT ON CONSTRAINT CorreoCajeroFK IS 'Restricción de Integridad Referencial para la tabla CorreoCajero';
COMMENT ON CONSTRAINT CajeroCorreo_valido IS 'Restricción de Dominio para el atributo CorreoCajero de la tabla CorreoCajero. Nos asegura que la dirección de correo electronico sea valida al añadir caracteres especiales más el separador @ para el dominio del correo electronico';


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
    ADD CONSTRAINT TecnicoCurp_valido CHECK (CURPTecnico ~ '^[A-Z0-9]{18}$'),
    ADD CONSTRAINT TecnicoFK FOREIGN KEY (IDSucursal)
        REFERENCES Sucursal(IDSucursal)
        ON DELETE CASCADE,
    ADD CONSTRAINT RFCTecnico_unico UNIQUE (RFCTecnico),
    ADD CONSTRAINT RFCTecnico_valido CHECK (RFCTecnico ~ '^[A-ZÑ0-9]{12,13}$'),
    ADD CONSTRAINT TecnicoNombre_valido CHECK (NombreTecnico ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(NombreTecnico)) > 0),
	ADD CONSTRAINT TecnicoApellidoP_valido CHECK (ApellidoPaternoTecnico ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoPaternoTecnico)) > 0),
	ADD CONSTRAINT TecnicoApellidoM_valido CHECK (ApellidoMaternoTecnico ~ '^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$' AND LENGTH(TRIM(ApellidoMaternoTecnico)) > 0),
    ADD CONSTRAINT TecnicoFechaCont_valido CHECK (FechaContratacionTecnico > FechaNacimientoTecnico)
    ADD CONSTRAINT SalarioTecnico_valido CHECK (SalarioTecnico > 0),
    ALTER COLUMN IDSucursal SET NOT NULL,
    ALTER COLUMN RFCTecnico SET NOT NULL,
    ALTER COLUMN NombreTecnico SET NOT NULL,
    ALTER COLUMN ApellidoPaternoTecnico SET NOT NULL,
    ALTER COLUMN ApellidoMaternoTecnico SET NOT NULL,
    ALTER COLUMN FechaNacimientoTecnico SET NOT NULL,
    ALTER COLUMN FechaContratacionTecnico SET NOT NULL,
    ALTER COLUMN SalarioTecnico SET NOT NULL,
    ALTER COLUMN Especialidad SET NOT NULL;

-- Comentarios

COMMENT ON TABLE Tecnico IS 'Tabla que representa a los Tecnicos';

COMMENT ON COLUMN Tecnico.CURPTecnico IS 'CURP del Técnico';
COMMENT ON COLUMN Tecnico.IDSucursal IS 'Identificador único de la Sucursal donde trabaja el Técnico';
COMMENT ON COLUMN Tecnico.RFCTecnico IS 'RFC del Técnico';
COMMENT ON COLUMN Tecnico.NombreTecnico IS 'Nombre de pila del Técnico';
COMMENT ON COLUMN Tecnico.ApellidoPaternoTecnico IS 'Apellido paterno del Técnico';
COMMENT ON COLUMN Tecnico.ApellidoMaternoTecnico IS 'Apellido materno del Técnico';
COMMENT ON COLUMN Tecnico.FechaNacimientoTecnico IS 'Fecha de nacimiento del Técnico';
COMMENT ON COLUMN Tecnico.FechaContratacionTecnico IS 'Fecha de contratación del Técnico';
COMMENT ON COLUMN Tecnico.SalarioTecnico IS 'Salario del Técnico';
COMMENT ON COLUMN Tecnico.Especialidad IS 'Especialidad del Técnico';

COMMENT ON CONSTRAINT TecnicoPK IS 'Restricción de Entidad para la tabla Tecnico';
COMMENT ON CONSTRAINT TecnicoCurp_valido IS 'Restricción de Dominio para el atributo CURPTecnico de la tabla Tecnico. Nos asegura que solo contenga letras mayusculas, números, y que su longitud total sea de 18 caracteres';
COMMENT ON CONSTRAINT TecnicoFK IS 'Restricción de Integridad referencial de la tabla Tecnico';
COMMENT ON CONSTRAINT RFCTecnico_unico IS 'Restricción de Dominio para el atributo RFCTecnico de la tabla Tecnico. No se pueden repetir los RFC ya que son unicos';
COMMENT ON CONSTRAINT RFCTecnico_valido IS 'Restricción de Dominio para el atributo RFCTecnico de la tabla Tecnico. Nos asegura que solo contenga letras mayusculas, números, y que la longitud total sea entre 12 y 13 cqaracteres';
COMMENT ON CONSTRAINT TecnicoNombre_valido IS 'Restricción de Dominio para el atributo NombreTecnico de la tabla Tecnico. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las vocales asentuadas estan permitidas';
COMMENT ON CONSTRAINT TecnicoApellidoP_valido IS 'Restricción de Dominio para el atributo ApellidoPaternoTecnico de la tabla Tecnico. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las vocales asentuadas estan permitidas';
COMMENT ON CONSTRAINT TecnicoApellidoM_valido IS 'Restricción de Dominio para el atributo ApellidoMaternoTecnico de la tabla Tecnico. Nos asegura que no este formado por espacios en blanco ni contenga caracteres especiales, las vocales asentuadas estan permitidas';
COMMENT ON CONSTRAINT TecnicoFechaCont_valido IS 'Restricción de Dominio para el atributo FechaContratacionTecnico de la tabla Tecnico. Nos asegura que la fecha de contratación sea despues de la fecha de nacimiento';
COMMENT ON CONSTRAINT SalarioTecnico_valido IS 'Restricción de Dominio para el atributo SalarioTecnico de la tabla Tecnico. Nos asegura que el salario sea un número positivo';


-- 13# TELEFONO TECNICO
CREATE TABLE TelefonoTecnico(
    CURPTecnico CHAR(18),
    TelefonoTecnico CHAR(10)
);


ALTER TABLE TelefonoTecnico
    ADD CONSTRAINT TelefonoTecnicoPK PRIMARY KEY (CURPTecnico, TelefonoTecnico),
    ADD CONSTRAINT TelefonoTecnicoFK FOREIGN KEY (CURPTecnico)
        REFERENCES Tecnico(CURPTecnico)
        ON DELETE CASCADE,
	ADD CONSTRAINT TecnicoTelefono_valido CHECK (TelefonoTecnico ~ '^[0-9]{10}$');

-- Comentarios

COMMENT ON TABLE TelefonoTecnico IS 'Tabla que representa los números de Teléfono de los Técnicos';

COMMENT ON COLUMN TelefonoTecnico.TelefonoTecnico IS 'Número de Teléfono del Técnico';
COMMENT ON COLUMN TelefonoTecnico.CURPTecnico IS 'CURP del Técnico al que está asociado el número de Teléfono';

COMMENT ON CONSTRAINT TelefonoTecnicoPK IS 'Restricción de Entidad para la tabla TelefonoTecnico';
COMMENT ON CONSTRAINT TelefonoTecnicoFK IS 'Restricción de Integridad referencial para la tabla TelefonoTecnico';
COMMENT ON CONSTRAINT TecnicoTelefono_valido IS 'Restricción de Dominio para el atributo TelefonoTecnico de la tabla TelefonoTecnico. Nos asegura que solo contenga los números del 0 al 9 y que su longitud total sea de 10 digitos';


-- 14# CORREO TECNICO
CREATE TABLE CorreoTecnico(
    CURPTecnico CHAR(18),
    CorreoTecnico VARCHAR(50)
);


ALTER TABLE CorreoTecnico 
    ADD CONSTRAINT CorreoTecnicoPK PRIMARY KEY (CURPTecnico, CorreoTecnico),
    ADD CONSTRAINT CorreoTecnicoFK FOREIGN KEY (CURPTecnico)
        REFERENCES Tecnico(CURPTecnico)
        ON DELETE CASCADE,
    ADD CONSTRAINT TecnicoCorreo_valido CHECK (
        CorreoTecnico ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );

-- Comentarios

COMMENT ON TABLE CorreoTecnico IS 'Tabla que representa los Correos electronicos de los Técnicos';

COMMENT ON COLUMN CorreoTecnico.CorreoTecnico IS 'Correo electronico del Técnico';
COMMENT ON COLUMN CorreoTecnico.CURPTecnico IS 'CURP del Técnico al que está asociado el Correo electronico';

COMMENT ON CONSTRAINT CorreoTecnicoPK IS 'Restricción de Entidad para la tabla CorreoTecnico';
COMMENT ON CONSTRAINT CorreoTecnicoFK IS 'Restricción de Integridad referencial para la tabla CorreoTecnico';
COMMENT ON CONSTRAINT TecnicoCorreo_valido IS 'Restricción de Dominio para el atributo CorreoTecnico de la tabla CorreoTecnico. Nos asegura que la direccción de correo electronico sea valido aceptando caracteres especiales más el separador @ para el dominio del correo electronico';


-- 15# CERTIFICACION
CREATE TABLE Certificacion(
    CURPTecnico CHAR(18),
    Certificacion VARCHAR(150)
);

ALTER TABLE Certificacion
    ADD CONSTRAINT CertificacionPK PRIMARY KEY (CURPTecnico, Certificacion),
    ADD CONSTRAINT CertificacionFK FOREIGN KEY (CURPTecnico)
        REFERENCES Tecnico(CURPTecnico)
        ON DELETE CASCADE,
    ADD CONSTRAINT Certificacion_valida CHECK (Certificacion ~'^[a-zA-Z0-9áéíóúÁÉÍÓÚüÜñÑ ]{0, 150}' AND LENGTH(TRIM(Certificacion)) > 0),
    ALTER COLUMN CURPTecnico SET NOT NULL;

-- Comentarios

COMMENT ON TABLE Certificacion IS 'Tabla que representa las Certificaciones de los Técnicos';

COMMENT ON COLUMN Certificacion.Certificacion IS 'Certificación realizada por el Técnico';
COMMENT ON COLUMN Certificacion.CURPTecnico IS 'CURP del Técnico al que está asociada la certificación';

COMMENT ON CONSTRAINT CertificacionPK IS 'Restricción de Entidad para la tabla Certificacion';
COMMENT ON CONSTRAINT CertificacionFK IS 'Restricción de Integridad referencial para la tabla Certificación';
COMMENT ON CONSTRAINT Certificacion_valida IS 'Restricción de Dominio para el atributo Certificacion de la tabla Certificacion. Nos asegura que no este formado por espacios en blanco y no contenga caracteres especiales, las vocales asentuadas estan permitidas';


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
	ADD CONSTRAINT IDCliente_Valida CHECK(IDCliente >= 0),
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

-- Comentarios

COMMENT ON TABLE Cliente IS 'Tabla que almacena la información de los clientes del sistema.';
COMMENT ON COLUMN Cliente.IDCliente IS 'Identificador único del cliente.';
COMMENT ON COLUMN Cliente.Nombre IS 'Nombre del cliente. Máximo 100 caracteres. Solo letras y espacios.';
COMMENT ON COLUMN Cliente.ApellidoP IS 'Apellido paterno del cliente. Máximo 100 caracteres. Solo letras y espacios.';
COMMENT ON COLUMN Cliente.ApellidoM IS 'Apellido materno del cliente. Máximo 100 caracteres. Solo letras y espacios.';
COMMENT ON COLUMN Cliente.FechaNacimiento IS 'Fecha de nacimiento del cliente. Debe tener al menos 12 años';
COMMENT ON CONSTRAINT pk_cliente ON Cliente IS 'Llave primaria de la tabla Cliente.';
COMMENT ON CONSTRAINT IDCliente_Valida ON Cliente IS 'Ve que el ID del cliente sea un número entero positivo.';
COMMENT ON CONSTRAINT chk_fecha_nacimiento ON Cliente IS 'Ve que la fecha de nacimiento del cliente sea válida y que tenga al menos 12 años.';
COMMENT ON CONSTRAINT ClienteNombre_valido ON Cliente IS 'Ve que el nombre del cliente contenga solo letras y espacios, y que no esté vacío.';
COMMENT ON CONSTRAINT ClienteApellidoP_valido ON Cliente IS 'Ve que el apellido paterno del cliente contenga solo letras y espacios, y que no esté vacío.';
COMMENT ON CONSTRAINT ClienteApellidoM_valido ON Cliente IS 'Ve que el apellido materno del cliente contenga solo letras y espacios, y que no esté vacío.';


 -- 17# TARJETA
CREATE TABLE Tarjeta (
    NoTarjeta INT
);

ALTER TABLE Tarjeta
    ADD CONSTRAINT Tarjeta_PK PRIMARY KEY (NoTarjeta),
    ADD CONSTRAINT NoTarjeta_Positivo CHECK (NoTarjeta >= 0);

COMMENT ON TABLE Tarjeta IS 'Tabla que almacena la información de las tarjetas de los clientes.';
COMMENT ON COLUMN Tarjeta.NoTarjeta IS 'Número de tarjeta único. Debe ser un número entero positivo.';
COMMENT ON CONSTRAINT Tarjeta_PK ON Tarjeta IS 'Clave primaria de la tabla Tarjeta.';
COMMENT ON CONSTRAINT NoTarjeta_Positivo ON Tarjeta IS 'Verifica que el número de tarjeta sea un número entero positivo.';

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
	ADD CONSTRAINT uq_pertenecer UNIQUE (IDCliente, NoTarjeta), -- Ahora si ya es PK lo siento :(
	ADD CONSTRAINT fk_pertenecer_cliente FOREIGN KEY (IDCliente) 
		REFERENCES Cliente(IDCliente) ON DELETE CASCADE,
	ADD CONSTRAINT fk_pertenecer_tarjeta FOREIGN KEY (NoTarjeta) 
		REFERENCES Tarjeta(NoTarjeta) ON DELETE CASCADE ON UPDATE CASCADE,
	ALTER COLUMN Nombre SET NOT NULL,
	ADD CONSTRAINT Pertenecer_Nombre_Valido CHECK (Nombre ~'^[A-Za-z-ÁÉÍÓÚÜÑáéíóúüñ ]+$' AND LENGTH(TRIM(Nombre)) > 0),
	ALTER COLUMN ApellidoP SET NOT NULL,
	ALTER COLUMN ApellidoM SET NOT NULL,
	ALTER COLUMN FechaNacimiento SET NOT NULL,
    ADD CONSTRAINT chk_fecha_nacimiento CHECK (
        FechaNacimiento >= '1909-01-01' AND 
        FechaNacimiento <= CURRENT_DATE - INTERVAL '12 years'
    );

COMMENT ON TABLE Pertenecer IS 'Tabla que relaciona clientes con sus tarjetas.';
COMMENT ON COLUMN Pertenecer.IDCliente IS 'Identificador del cliente.';
COMMENT ON COLUMN Pertenecer.NoTarjeta IS 'Número de tarjeta asociado al cliente.';
COMMENT ON COLUMN Pertenecer.Nombre IS 'Nombre del cliente. Máximo 100 caracteres. Solo letras y espacios.';
COMMENT ON COLUMN Pertenecer.ApellidoP IS 'Apellido paterno del cliente. Máximo 100 caracteres. Solo letras y espacios.';
COMMENT ON COLUMN Pertenecer.ApellidoM IS 'Apellido materno del cliente. Máximo 100 caracteres. Solo letras y espacios.';
COMMENT ON COLUMN Pertenecer.FechaNacimiento IS 'Fecha de nacimiento del cliente. Debe tener al menos 12 años.';

COMMENT ON CONSTRAINT uq_pertenecer ON Pertenecer IS 'Ve que la combinación de IDCliente y NoTarjeta sea única.';
COMMENT ON CONSTRAINT fk_pertenecer_cliente ON Pertenecer IS 'Llave foránea que referencia a la tabla Cliente.';
COMMENT ON CONSTRAINT fk_pertenecer_tarjeta ON Pertenecer IS 'Llave foránea que referencia a la tabla Tarjeta.';
COMMENT ON CONSTRAINT Pertenecer_Nombre_Valido ON Pertenecer IS 'Ve que el nombre del cliente contenga solo letras y espacios, y que no esté vacío.';
COMMENT ON CONSTRAINT chk_fecha_nacimiento ON Pertenecer IS 'Ve que la fecha de nacimiento del cliente sea válida y que tenga al menos 12 años.';
    
 -- 19# CORREO CLIENTE
CREATE TABLE CorreoCliente (
	IDCliente INT,
	CorreoCliente VARCHAR(76)
);

ALTER TABLE CorreoCliente
	ADD CONSTRAINT pk_correocliente PRIMARY KEY (IDCliente, CorreoCliente), 
	ADD CONSTRAINT fk_correocliente_cliente FOREIGN KEY (IDCliente) 
		REFERENCES Cliente(IDCliente) ON DELETE CASCADE,
    ADD CONSTRAINT chk_correo_formato CHECK (
        CorreoCliente ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' 
    );-- Uno supondría que aquí debería discutirse. 
    -- "string de al menos un caracter sin @" + "@" + "string de al menos un caracter sin @" + "$" (fin de cadena)
       

COMMENT ON TABLE CorreoCliente IS 'Tabla que almacena los correos electrónicos de los clientes.';
COMMENT ON COLUMN CorreoCliente.IDCliente IS 'Identificador del cliente.';
COMMENT ON COLUMN CorreoCliente.CorreoCliente IS 'Correo electrónico del cliente. Debe tener un formato válido de correo electrónico.';
COMMENT ON CONSTRAINT pk_correocliente ON CorreoCliente IS 'Llave primaria de la tabla CorreoCliente.';
COMMENT ON CONSTRAINT fk_correocliente_cliente ON CorreoCliente IS 'Llave foránea que referencia a la tabla Cliente.';
COMMENT ON CONSTRAINT chk_correo_formato ON CorreoCliente IS 'Verifica que el correo electrónico tenga un formato válido.';
    
 -- 20# TELEFONO CLIENTE
CREATE TABLE TelefonoCliente (
	IDCliente INT,
	TelefonoCliente VARCHAR(10)
);

ALTER TABLE TelefonoCliente
	ADD CONSTRAINT pk_telefonocliente PRIMARY KEY (IDCliente, TelefonoCliente),
	ADD CONSTRAINT fk_telefonocliente_cliente FOREIGN KEY (IDCliente) 
		REFERENCES Cliente(IDCliente) ON DELETE CASCADE,
    ADD CONSTRAINT chk_telefono_formato CHECK (TelefonoCliente ~ '^[0-9]{10}$'); 

COMMENT ON TABLE TelefonoCliente IS 'Tabla que almacena los números de teléfono de los clientes.';
COMMENT ON COLUMN TelefonoCliente.IDCliente IS 'Identificador del cliente.';
COMMENT ON COLUMN TelefonoCliente.TelefonoCliente IS 'Número de teléfono del cliente. Debe tener 10 dígitos.';
COMMENT ON CONSTRAINT pk_telefonocliente ON TelefonoCliente IS 'Llave primaria de la tabla TelefonoCliente.';
COMMENT ON CONSTRAINT fk_telefonocliente_cliente ON TelefonoCliente IS 'Llave foránea que referencia a la tabla Cliente.';
COMMENT ON CONSTRAINT chk_telefono_formato ON TelefonoCliente IS 'Verifica que el número de teléfono tenga un formato válido de 10 dígitos.';



-- 21# JUEGO
CREATE TABLE Juego(
	IDJuego INT ,
	Nombre VARCHAR(100) ,
	Costo INT ,
	TipoJuego VARCHAR(30) 
);

ALTER TABLE Juego	
	ADD CONSTRAINT Juego_PK PRIMARY KEY (IDJuego), 
    ADD CONSTRAINT IDJuego_Positivo CHECK (IDJuego >= 0),
	ALTER COLUMN Nombre SET NOT NULL,
	ADD CONSTRAINT Nombre_Juego_Minimamente_Valido CHECK (TRIM(Nombre) <> ''),
	ALTER COLUMN Costo SET NOT NULL,
	ADD CONSTRAINT Costo_Juego_Valido CHECK (Costo >= 0 AND Costo % 10 = 0), 
	ALTER COLUMN TipoJuego SET NOT NULL, 
	ADD CONSTRAINT Tipo_Juego_Valido CHECK (TipoJuego IN ('Destreza','Disparos', 'Velocidad' , 'Ritmo'));

-- Comentarios
COMMENT ON TABLE Juego IS 'Tabla que almacena la información de un juego';

COMMENT ON COLUMN Juego.IDJuego IS 'Identificador único de cada juego que posee PuellaGames.';
COMMENT ON COLUMN Juego.Nombre IS 'Título o nombre del juego.';
COMMENT ON COLUMN Juego.Costo IS 'Costo para jugar el juego.';
COMMENT ON COLUMN Juego.TipoJuego IS 'El tipo del juego: Destreza, Disparos, Velocidad, Ritmo';

COMMENT ON CONSTRAINT Juego_PK ON Juego IS 'La llave primaria del Juego.';

COMMENT ON CONSTRAINT IDJuego_Positivo ON Juego IS 'El identificador del juego es un entero no negativo.';
COMMENT ON CONSTRAINT Nombre_Juego_Minimamente_Valido ON Juego IS 'El nombre del juego no es una cadena de puros espacios';
COMMENT ON CONSTRAINT Costo_Juego_Valido ON Juego IS 'El costo del juego es un entero no negativo multiplo de 10.';
COMMENT ON CONSTRAINT Tipo_Juego_Valido ON Juego IS 'El tipo de juego, pertenece a alguno de los tipos válidos.';

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
	ADD CONSTRAINT IDMaquina_valida CHECK (IDMaquina >= 0),
	ALTER COLUMN IDSucursal SET NOT NULL,
	ADD CONSTRAINT Maquina_FK01S FOREIGN KEY (IDSucursal) 
		REFERENCES Sucursal (IDSucursal)  
		ON DELETE SET DEFAULT -- Integridad referencial. 
		ON UPDATE CASCADE,
	ADD CONSTRAINT Maquina_FK02J FOREIGN KEY (IDJuego) 
		REFERENCES Juego (IDJuego)
		ON DELETE SET NULL -- Integridad referencial. 
		ON UPDATE CASCADE,
	ALTER COLUMN EstadoMaquina SET NOT NULL,
	ADD CONSTRAINT Estado_Maquina_Valido CHECK (EstadoMaquina IN ('Activo', 'FueraDeServicio', 'Mantenimiento'));

-- Comentarios
COMMENT ON TABLE Maquina IS 'Tabla que almacena la información de una máquina';

COMMENT ON COLUMN Maquina.IDMaquina IS 'Identificador de cualquier máquina que PuellaGames posee.';
COMMENT ON COLUMN Maquina.IDSucursal IS 'Identificador de la sucursal a la que pertenece la máquina.';
COMMENT ON COLUMN Maquina.IDJuego IS 'Identificador del juego que posee la máquina.';
COMMENT ON COLUMN Maquina.EstadoMaquina IS 'El estado actual de la máquina: Activo, FueraDeServicio, Mantenimiento.';

COMMENT ON CONSTRAINT Maquina_PK ON Maquina IS 'La llave primaria de la tabla Maquina.';

COMMENT ON CONSTRAINT IDMaquina_valida ON Maquina IS 'Dice si el ID de una máquina es un entero no negativo.' ;
COMMENT ON CONSTRAINT Maquina_FK01S ON Maquina IS 'Llave foránea N0. 1 de máquina: Tomada de la tabla Sucursal.';
COMMENT ON CONSTRAINT Maquina_FK02J ON Maquina IS 'Llave foránea NO. 2 de máquina: Tomada de la tabla Juego.';
COMMENT ON CONSTRAINT Estado_Maquina_Valido ON Maquina IS 'El estado de la máquina dado, pertenece a uno de los estados válidos.';


-- 23# PREMIO
CREATE TABLE Premio(
	IDPremio INT, 
	Nombre VARCHAR(100),
	RangoEdad VARCHAR(8),
	ValorAproximado NUMERIC(6,2)
);

ALTER TABLE Premio
	ADD CONSTRAINT Premio_PK PRIMARY KEY (IDPremio),
    ADD CONSTRAINT IDPremio_Positivo CHECK (IDPremio >= 0),
	ALTER COLUMN Nombre SET NOT NULL,
	ADD CONSTRAINT Nombre_Premio_Minimamente_Válido CHECK (TRIM(Nombre) <> ''),
	ALTER COLUMN RangoEdad SET NOT NULL,
	ADD CONSTRAINT Premio_Rango_Edad_Valido CHECK (RangoEdad IN ('Infantil', 'Juvenil', 'Adulto')),
	ALTER COLUMN ValorAproximado SET NOT NULL,
	ADD CONSTRAINT Premio_Valor_Valido CHECK (ValorAproximado >= 0 AND ValorAproximado < 10000);    

-- Comentarios

COMMENT ON TABLE Premio IS 'Almacena la información de los premios registrados en una Sucursal';
COMMENT ON COLUMN Premio.IDPremio IS 'Identificador del Premio';
COMMENT ON COLUMN Premio.Nombre IS 'Nombre asignado al Premio';
COMMENT ON COLUMN Premio.RangoEdad IS 'Rango de Edades a las que es dirigido el Premio';
COMMENT ON COLUMN Premio.ValorAproximado IS 'Valor monetario Aproximado del premio';
COMMENT ON CONSTRAINT Premio_PK ON Premio IS 'Garantiza que cada cliente tenga un identificador único';
COMMENT ON CONSTRAINT IDPremio_Positivo ON Premio IS 'El identificador debe poseer un identicador con etiqueta positiva';
COMMENT ON CONSTRAINT Nombre_Premio_Minimamente_Válido ON Premio IS 'El nombre del premio es Obligatorio y no admite valores nulos';
COMMENT ON CONSTRAINT Premio_Rango_Edad_Valido ON Premio IS 'El dominio de los valores son <Infantil,Juvenil,Adulto>';
COMMENT ON CONSTRAINT Premio_Valor_Valido ON Premio IS 'El valor Aproximado del premio es positivo y no supera los 10,000$';
	


-- 24# REGISTRO PARTIDA

CREATE TABLE RegistroPartida(
	IDRegistro INT,
	IDMaquina INT,
	NoTarjeta INT,
	Fecha DATE,
	Hora TIME,	
	Puntuacion INT
);	

ALTER TABLE RegistroPartida 
	ALTER COLUMN IDMaquina SET NOT NULL,
	ALTER COLUMN NoTarjeta SET NOT NULL,
	ALTER COLUMN Fecha SET NOT NULL,
	ALTER COLUMN Hora SET NOT NULL,
	ALTER COLUMN Puntuacion SET NOT NULL,
	ADD CONSTRAINT RegistroPartida_PK PRIMARY KEY (IDRegistro),
	ADD CONSTRAINT IDRegistro_Valido CHECK(IDRegistro >= 0),
	ADD CONSTRAINT  RegistroPartida_FK01M FOREIGN KEY (IDMaquina) REFERENCES Maquina(IDMaquina)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	ADD CONSTRAINT  RegistroPartida_FK02T FOREIGN KEY (NoTarjeta) REFERENCES Tarjeta(NoTarjeta)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,
	ADD CONSTRAINT RegistroPartida_DOM01 CHECK (Puntuacion >= 0),
	ADD CONSTRAINT RegistroPartida_DOM02 CHECK (Fecha <= CURRENT_DATE);

-- Comentarios
COMMENT ON TABLE RegistroPartida IS 'Tabla que registra el historial de las partidas jugadas en la maquina, su fecha y hora, la tarjeta utilizada para jugar y la puntuación obtenida al finalizar el juego.';

COMMENT ON COLUMN RegistroPartida.IDRegistro IS 'Identificador único de cada partida que se ha registrado';
COMMENT ON COLUMN RegistroPartida.IDMaquina IS 'El identificador de la máquina donde se realizó la partida';
COMMENT ON COLUMN RegistroPartida.NoTarjeta IS 'El número de tarjeta utilizada para jugar la partida';
COMMENT ON COLUMN RegistroPartida.Fecha IS 'La fecha en la que se realizó la partida.';
COMMENT ON COLUMN RegistroPartida.Hora IS 'La hora en la que se realizó la partida';
COMMENT ON COLUMN RegistroPartida.Puntuacion IS 'La puntuación obtenida al finalizar la partida';

COMMENT ON CONSTRAINT RegistroPartida_PK ON RegistroPartida IS 'La llave primaria que identifica a cada partida registrada de forma única';
COMMENT ON CONSTRAINT IDRegistro_Valido ON RegistroPartida IS 'Verificación de que el identificador de cada partida registrada sea un número mayor a 0';
COMMENT ON CONSTRAINT RegistroPartida_FK01M ON RegistroPartida IS 'Llave foránea proviniente de Maquina';
COMMENT ON CONSTRAINT RegistroPartida_FK02T ON RegistroPartida IS 'Llave foránea proveniente de Tarjeta';
COMMENT ON CONSTRAINT RegistroPartida_DOM01 ON RegistroPartida IS 'Verifica que la puntuación obtenida en la partida sea un número mayor o igual a 0, es decir, que la puntuación no puede ser negativa';
COMMENT ON CONSTRAINT RegistroPartida_DOM02 ON RegistroPartida IS 'Verifiva que la fecha de la partida registrada sea válida';


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
    ADD CONSTRAINT IDCanjeo_Positivo CHECK (IDCanjeo >= 0),
	ALTER COLUMN NoTarjeta SET NOT NULL,
	ADD CONSTRAINT Canje_FK01T FOREIGN KEY (NoTarjeta) 
		REFERENCES Tarjeta(NoTarjeta)
	   ON DELETE RESTRICT 
	   ON UPDATE CASCADE,
	ALTER COLUMN CURPEncPremios SET NOT NULL,
	ADD CONSTRAINT Canje_FK02E FOREIGN KEY (CURPEncPremios) 
	 	REFERENCES EncargadoPremios(CURPEncPremios)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
	ALTER COLUMN Fecha SET NOT NULL, 
	ALTER COLUMN Hora SET NOT NULL;
    
--Comentarios

COMMENT ON TABLE Canje IS 'Registra la infomación del Canje de un premio';
COMMENT ON COLUMN Canje.IDCanjeo IS 'Identificador del Canje';
COMMENT ON COLUMN Canje.NoTarjeta IS 'Número de Tarjeta del Cliente asociado al Canje';
COMMENT ON COLUMN Canje.CURPEncPremios IS 'Curp del Encargado de Premios que realiza el Canje';
COMMENT ON COLUMN Canje.Fecha IS 'Fecha registrada durante el Canje';
COMMENT ON COLUMN Canje.Hora IS 'Hora registrada durante el Canje';

COMMENT ON CONSTRAINT Canje_PK ON Canje IS 'El identificador del Canje es único';
COMMENT ON CONSTRAINT IDCanjeo_Positivo ON Canje IS 'El identificador debe poseer una etiqueta positiva';
COMMENT ON CONSTRAINT Canje_FK01T ON Canje IS 'Establece la relación entre la tabla Canje y Tarjeta, Un canje se realiza a tráves de una Tarjeta';
COMMENT ON CONSTRAINT Canje_FK02E ON Canje Is 'Establece la relación entre la tabla Canje y EncargadoPremios, Los canjes son realizados por el Encargado de Premios';

	
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
		REFERENCES Cajero(CURPCajero)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
	ALTER COLUMN NoTarjeta SET NOT NULL,
	ADD CONSTRAINT Recarga_FK02T FOREIGN KEY (NoTarjeta) 
		REFERENCES Tarjeta(NoTarjeta)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
	ALTER COLUMN Fecha SET NOT NULL,
	ALTER COLUMN Hora SET NOT NULL,
	ALTER COLUMN Monto SET NOT NULL,
	ADD CONSTRAINT Recarga_Monto_Valido CHECK (Monto >= 0 AND Monto % 10 = 0),
	ALTER COLUMN MetodoAbono SET NOT NULL,
	ADD CONSTRAINT Recarga_MetodoAbono_Valido CHECK ( MetodoAbono IN ('Efectivo', 'TarjetaDebito','TarjetaCredito', 'Paypal'));

--Comentarios

COMMENT ON TABLE Recarga IS 'Registra la información de una Recarga monetaria hacia una Tarjeta';
COMMENT ON COLUMN Recarga.CURPCajero IS 'Curp del Cajero';
COMMENT ON COLUMN Recarga.NoTarjeta IS 'Número de la Tarjeta';
COMMENT ON COLUMN Recarga.Fecha IS 'Fecha en la que se realizo la Recarga';
COMMENT ON COLUMN Recarga.Hora Is 'Hora en la que se realizo la Recarga';
COMMENT ON COLUMN Recarga.Monto Is 'Total del monto Abonado en la Recarga';
COMMENT ON COLUMN Recarga.MetodoAbono IS 'Forma de pago durante la recarga. Son Efectivo, Debito, Credito o Paypal';

COMMENT ON CONSTRAINT Recarga_FK01C ON Recarga IS'Establece la relación entre la tabla Recarga y Cajero, La recarga se hace con un Cajero';
COMMENT ON CONSTRAINT Recarga_FK02T ON Recarga IS'Establece la relación entre la tabla Recarga y Tarejeta, La recarga es abonada a una tarjeta';
COMMENT ON CONSTRAINT Recarga_Monto_Valido ON Recarga IS 'El monto debe ser un valor positivo multiplo de 10';
COMMENT ON CONSTRAINT Recarga_MetodoAbono_Valido ON Recarga IS 'La forma de pago tiene que corresponder con una de las disponibles';
COMMENT ON CONSTRAINT Recarga_FK01C ON Recarga IS 'Establece la relación entre la tabla Recarga y Cajero, La recarga se hace con un Cajero';
COMMENT ON CONSTRAINT Recarga_FK02T ON Recarga IS 'Establece la relación entre la tabla Recarga y Tarejeta, La recarga es abonada a una tarjeta';
COMMENT ON CONSTRAINT Recarga_Monto_Valido ON Recarga IS 'El monto debe ser un valor positivo multiplo de 10';
COMMENT ON CONSTRAINT Recarga_MetodoAbono_Valido ON Recarga IS 'La forma de pago tiene que corresponder con una de las disponibles';


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
	ADD CONSTRAINT Guardar_FK01S FOREIGN KEY (IDSucursal) REFERENCES Sucursal(IDSucursal)
		ON DELETE CASCADE ON UPDATE CASCADE,
	ADD CONSTRAINT Guardar_FK02P FOREIGN KEY (IDPremio) REFERENCES Premio(IDPremio)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	ADD CONSTRAINT Guardar_DOM01 CHECK (CantidadInicial >= 0);

-- Comentarios
COMMENT ON TABLE Guardar IS 'Tabla que representa los premios guardados en cada sucursal';

COMMENT ON COLUMN Guardar.IDSucursal IS 'Identificador de la Sucursal en la que se busca guardar el premio';
COMMENT ON COLUMN Guardar.IDPremio IS 'Identificador del Premio que se busca guardar';
COMMENT ON COLUMN Guardar.CantidadInicial IS 'Cantidad de premios que se buscan guardar';

COMMENT ON CONSTRAINT Guardar_FK01S ON Guardar IS 'Llave foránea a la tabla Sucursal';
COMMENT ON CONSTRAINT Guardar_FK02P ON Guardar IS 'Llave foránea a la tabla Premio';

COMMENT ON CONSTRAINT Guardar_DOM01 ON Guardar IS 'La cantidad inicial de premios debe ser mayor o igual a cero';

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
		REFERENCES Premio(IDPremio)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
	ALTER COLUMN IDCanjeo SET NOT NULL,
	ADD CONSTRAINT Incluir_FK02C FOREIGN KEY (IDCanjeo)
		REFERENCES Canje(IDCanjeo)
        ON DELETE RESTRICT 
        ON UPDATE CASCADE,
	ALTER COLUMN Cantidad SET NOT NULL,
	ADD CONSTRAINT Incluir_Cantidad_Valida CHECK (Cantidad >= 1);

-- Comentarios

COMMENT ON TABLE Incluir Is 'Tabla que representa que un Canje Incuye un Premio';
COMMENT ON COLUMN Incluir.IDPremio IS 'Identificador único del premio';
COMMENT ON COLUMN Incluir.IDCanjeo IS 'Identificador único del Canje';
COMMENT ON COLUMN Incluir.Cantidad Is 'Cantidad de premios que incluye el Canje';
COMMENT ON CONSTRAINT Incluir_FK01P ON Incluir IS 'Establece la relación entre la tabla Incluye y premio, Un premio es Incluido en un canje';
COMMENT ON CONSTRAINT Incluir_FK02C ON Incluir IS 'Establece la relación entre la tabla Incluye y canje, Un canje es Incluido para un premio';
COMMENT ON CONSTRAINT Incluir_Cantidad_Valida ON  Incluir IS 'Debe haber al menos un premio pára realizar el Canje';


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
    ADD CONSTRAINT IDMantenimiento_Valido CHECK (IDMantenimiento >= 0),
	ALTER COLUMN CURPTecnico SET NOT NULL,
	ADD CONSTRAINT Mantenimiento_FK01C FOREIGN KEY (CURPTecnico)
		REFERENCES Tecnico(CURPTecnico)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	ALTER COLUMN IDMaquina SET NOT NULL,
	ADD CONSTRAINT Mantenimiento_FK02I FOREIGN KEY (IDMaquina)
		REFERENCES Maquina(IDMaquina)
		ON DELETE RESTRICT ON UPDATE CASCADE,
    ALTER COLUMN Hora SET NOT NULL,
    ALTER COLUMN Fecha SET NOT NULL,
    ALTER COLUMN TipoMantenimiento SET NOT NULL,
    ALTER COLUMN Descripcion SET NOT NULL;

ALTER TABLE Mantenimiento 
    ALTER COLUMN Descripcion TYPE TEXT;

-- Comentarios
COMMENT ON TABLE Mantenimiento IS 'Tabla que representa las Maquinas en Mantenimiento designado a un Tecnico';

COMMENT ON COLUMN Mantenimiento.IDMantenimiento IS 'Identificador del reporte de mantenimiento';
COMMENT ON COLUMN Mantenimiento.CURPTecnico IS 'Identificador del Tecnico que realiza el mantenimiento';
COMMENT ON COLUMN Mantenimiento.IDMaquina IS 'Identificador de la Maquina que se encuentra en mantenimiento';
COMMENT ON COLUMN Mantenimiento.Hora IS 'Hora en la que se realiza el mantenimiento';
COMMENT ON COLUMN Mantenimiento.Fecha IS 'Fecha en la que se realiza el mantenimiento';
COMMENT ON COLUMN Mantenimiento.TipoMantenimiento IS 'Tipo de mantenimiento que se realiza';
COMMENT ON COLUMN Mantenimiento.Descripcion IS 'Descripcion del mantenimiento que se realiza';

COMMENT ON CONSTRAINT Mantenimiento_PK ON Mantenimiento IS 'Llave primaria de la tabla Mantenimiento';

COMMENT ON CONSTRAINT IDMantenimiento_Valido ON Mantenimiento IS 'Identificador de Maquina en Mantenimiento debe ser mayor o igual a cero';
COMMENT ON CONSTRAINT Mantenimiento_FK01C ON Mantenimiento IS 'Llave foránea a la tabla Tecnico';
COMMENT ON CONSTRAINT Mantenimiento_FK02I ON Mantenimiento IS 'Llave foránea a la tabla Maquina';


