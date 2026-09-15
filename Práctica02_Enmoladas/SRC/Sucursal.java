/**
 * Esta clase representa la Sucursal, una de las Entidades identificadas del Centro de Entretenimiento Familiar.
 * Se encarga de manejar la información de cada sucursal, como su nombre, dirección, horarios, etc. (atributos/informacion particular de c/Sucursal)
 * Cada sucursal se diferencia entre sí por su identificador único, idSucursal.
 * Ademas tiene metodos getters y setters para acceder a sus atributos, ademas de un constructor, un constructor por defecto, un metodo toString, 
 * consultar, actualizar, cargar y validar (heredados de ArchivoCSV).
 *
 * Formato CSV:
 * idSucursal,nombre,calle,numInterior,numExterior,colonia,estado,telefono,horarios
 *
 * @author Enmoladas
 */
public class Sucursal implements ArchivoCSV {

    /** Identificador único de la sucursal (ej. S001). */
    private String idSucursal;
    
    /** Nombre representativo de la sucursal. */
    private String nombre;
    
    /** Calle donde se ubica la sucursal. */
    private String calle;
    
    /** Número interior del local (puede ser vacío o '-' si no tiene). */
    private String numInterior;
    
    /** Número exterior del local. */
    private String numExterior;
    
    /** Colonia donde se ubica la sucursal. */
    private String colonia;
    
    /** Estado de la República donde se encuentra la sucursal. */
    private String estado;
    
    /** Número de teléfono de contacto de la sucursal. */
    private String telefono;
    
    /** Horarios de atención de la sucursal. */
    private String horarios;

    /**
     * Constructor por defecto.
     * Inicializa todos los atributos de la sucursal con cadenas vacías para evitar valores nulos.
     */
    public Sucursal() {
        this.idSucursal = "";
        this.nombre = "";
        this.calle = "";
        this.numInterior = "";
        this.numExterior = "";
        this.colonia = "";
        this.estado = "";
        this.telefono = "";
        this.horarios = "";
    }

    /**
     * Constructor con todos los atributos.
     * Permite instanciar una sucursal con todos sus datos desde el momento de su creación.
     *
     * @param idSucursal   El identificador único.
     * @param nombre       El nombre de la sucursal.
     * @param calle        La calle de su dirección.
     * @param numInterior  El número interior (si aplica).
     * @param numExterior  El número exterior.
     * @param colonia      La colonia.
     * @param estado       El estado.
     * @param telefono     El teléfono de contacto.
     * @param horarios     Los horarios de atención.
     */
    public Sucursal(String idSucursal, String nombre, String calle, String numInterior,
                    String numExterior, String colonia, String estado, String telefono,
                    String horarios) {
        this.idSucursal = idSucursal;
        this.nombre = nombre;
        this.calle = calle;
        this.numInterior = numInterior;
        this.numExterior = numExterior;
        this.colonia = colonia;
        this.estado = estado;
        this.telefono = telefono;
        this.horarios = horarios;
    }

    /** @return El identificador de la sucursal. */
    public String getIdSucursal() { return idSucursal; }
    
    /** @param idSucursal El nuevo identificador para la sucursal. */
    public void setIdSucursal(String idSucursal) { this.idSucursal = idSucursal; }

    /** @return El nombre de la sucursal. */
    public String getNombre() { return nombre; }
    
    /** @param nombre El nuevo nombre para la sucursal. */
    public void setNombre(String nombre) { this.nombre = nombre; }

    /** @return La calle de la sucursal. */
    public String getCalle() { return calle; }
    
    /** @param calle La nueva calle para la sucursal. */
    public void setCalle(String calle) { this.calle = calle; }

    /** @return El número interior de la sucursal. */
    public String getNumInterior() { return numInterior; }
    
    /** @param numInterior El nuevo número interior para la sucursal. */
    public void setNumInterior(String numInterior) { this.numInterior = numInterior; }

    /** @return El número exterior de la sucursal. */
    public String getNumExterior() { return numExterior; }
    
    /** @param numExterior El nuevo número exterior para la sucursal. */
    public void setNumExterior(String numExterior) { this.numExterior = numExterior; }

    /** @return La colonia de la sucursal. */
    public String getColonia() { return colonia; }
    
    /** @param colonia La nueva colonia para la sucursal. */
    public void setColonia(String colonia) { this.colonia = colonia; }

    /** @return El estado de la sucursal. */
    public String getEstado() { return estado; }
    
    /** @param estado El nuevo estado para la sucursal. */
    public void setEstado(String estado) { this.estado = estado; }

    /** @return El teléfono de la sucursal. */
    public String getTelefono() { return telefono; }
    
    /** @param telefono El nuevo teléfono para la sucursal. */
    public void setTelefono(String telefono) { this.telefono = telefono; }

    /** @return Los horarios de la sucursal. */
    public String getHorarios() { return horarios; }
    
    /** @param horarios Los nuevos horarios para la sucursal. */
    public void setHorarios(String horarios) { this.horarios = horarios; }

    /**
     * Verifica si esta sucursal corresponde a la llave primaria buscada.
     * @param llave El idSucursal a buscar.
     * @return true si coinciden los identificadores, false en caso contrario.
     */
    @Override
    public boolean consultar(String llave) {
        return this.idSucursal.equals(llave);
    }

    /**
     * Reemplaza todos los datos de esta sucursal por los de otra recibida como parámetro.
     * @param o Un objeto de tipo Sucursal del cual se copiarán los datos.
     * @throws IllegalArgumentException si el objeto recibido no es una Sucursal.
     */
    @Override
    public void actualizar(Object o) {
        if (!(o instanceof Sucursal)) throw new IllegalArgumentException("El objeto no es una Sucursal.");
        Sucursal s = (Sucursal) o;
        this.idSucursal = s.idSucursal;
        this.nombre = s.nombre;
        this.calle = s.calle;
        this.numInterior = s.numInterior;
        this.numExterior = s.numExterior;
        this.colonia = s.colonia;
        this.estado = s.estado;
        this.telefono = s.telefono;
        this.horarios = s.horarios;
    }

    /**
     * Convierte los datos de la sucursal en una cadena separada por comas para guardar en el archivo.
     * @return Representación en texto CSV de la sucursal.
     */
    @Override
    public String getCSV() {
        return idSucursal + "," + nombre + "," + calle + "," + numInterior + "," + 
               numExterior + "," + colonia + "," + estado + "," + telefono + "," + horarios;
    }

    /**
     * Asigna los atributos de la sucursal a partir de una cadena CSV leída del archivo.
     * @param csv Cadena de texto con los campos separados por comas.
     * @throws IllegalArgumentException si la cadena no tiene suficientes campos.
     */
    @Override
    public void cargar(String csv) throws IllegalArgumentException {
        String[] partes = csv.split(",", -1);
        if (partes.length < 9) {
            throw new IllegalArgumentException("Formato CSV inválido para Sucursal.");
        }
        this.idSucursal = partes[0].trim();
        this.nombre = partes[1].trim();
        this.calle = partes[2].trim();
        this.numInterior = partes[3].trim();
        this.numExterior = partes[4].trim();
        this.colonia = partes[5].trim();
        this.estado = partes[6].trim();
        this.telefono = partes[7].trim();
        this.horarios = partes[8].trim();
        
        this.validar();
    }

    /**
     * Valida que la información de la sucursal cumpla con las reglas del negocio antes de ser guardada.
     * Verifica que los campos obligatorios no estén vacíos y que formatos numéricos sean correctos.
     * @throws IllegalArgumentException si alguna regla de validación falla.
     */
    public void validar() {
        if (idSucursal == null || !idSucursal.matches("S\\d{3}")) {
            throw new IllegalArgumentException("El ID de la sucursal debe tener el formato S### (ej. S001).");
        }
        if (nombre == null || !nombre.matches("[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+")) {
            throw new IllegalArgumentException("El nombre solo debe contener letras.");
        }
        if (calle == null || !calle.matches("[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+")) {
            throw new IllegalArgumentException("La calle solo debe contener letras.");
        }
        if (numExterior == null || !numExterior.matches("\\d+")) {
            throw new IllegalArgumentException("El número exterior debe contener únicamente números.");
        }
        if (colonia == null || !colonia.matches("[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+")) {
            throw new IllegalArgumentException("La colonia solo debe contener letras.");
        }
        if (estado == null || !estado.matches("[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+")) {
            throw new IllegalArgumentException("El estado solo debe contener letras.");
        }
        if (numInterior == null || !numInterior.matches("\\d+")) {
            throw new IllegalArgumentException("El número interior debe contener únicamente números.");
        }
        if (telefono == null || !telefono.matches("\\d+")) {
            throw new IllegalArgumentException("El teléfono debe contener únicamente números.");
        }
        if (horarios == null || !horarios.matches("([01]\\d|2[0-3]):([0-5]\\d)")) {
            throw new IllegalArgumentException("Los horarios deben tener el formato ##:## de 24 horas (ej. 14:30).");
        }
    }

    /**
     * Compara esta sucursal con otro objeto para determinar si son iguales.
     * Dos sucursales se consideran iguales si todos sus atributos son idénticos.
     * @param o El objeto con el cual comparar.
     * @return true si el objeto es una sucursal con los mismos datos, false de lo contrario.
     */
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Sucursal sucursal = (Sucursal) o;
        return (idSucursal != null ? idSucursal.equals(sucursal.idSucursal) : sucursal.idSucursal == null) &&
               (nombre != null ? nombre.equals(sucursal.nombre) : sucursal.nombre == null) &&
               (calle != null ? calle.equals(sucursal.calle) : sucursal.calle == null) &&
               (numInterior != null ? numInterior.equals(sucursal.numInterior) : sucursal.numInterior == null) &&
               (numExterior != null ? numExterior.equals(sucursal.numExterior) : sucursal.numExterior == null) &&
               (colonia != null ? colonia.equals(sucursal.colonia) : sucursal.colonia == null) &&
               (estado != null ? estado.equals(sucursal.estado) : sucursal.estado == null) &&
               (telefono != null ? telefono.equals(sucursal.telefono) : sucursal.telefono == null) &&
               (horarios != null ? horarios.equals(sucursal.horarios) : sucursal.horarios == null);
    }

    /**
     * Genera una representación en formato de texto legible para mostrar la información 

     * en la consola al realizar consultas.
     * @return Una cadena formateada con los datos de la sucursal.
     */
    @Override
    public String toString() {
        String nroInt = (numInterior != null && !numInterior.isEmpty()) ? " Int. " + numInterior : "";
        String direccion = calle + " #" + numExterior + nroInt + ", Col. " + colonia + ", " + estado;
        return "Sucursal {" +
                "idSucursal='" + idSucursal + '\'' +
                ", nombre='" + nombre + '\'' +
                ", direccion='" + direccion + '\'' +
                ", telefono='" + telefono + '\'' +
                ", horarios='" + horarios + '\'' +
                '}';
    }
}
