/**
 * Representa a un cliente dentro del centro de entretenimiento familiar Puella Game.
 * Implementa ArchivoCSV para integrarse al menú del sistema.
 *
 * Formato CSV:
 * id_cliente,nombre,apPaterno,apMaterno,telefono,correo,puntos,calle,numero,colonia,cp
 *
 * @author Integrante 4
 * @version 1.0
 */
public class Cliente implements ArchivoCSV {

    /** Llave de la entidad. Formato esperado: C### (ej. C001). */
    private String idCliente;

    /** Nombre del cliente. No puede ser vacío. */
    private String nombre;

    /** Apellido paterno del cliente. No puede ser vacío. */
    private String apPaterno;

    /** Apellido materno del cliente. No puede ser vacío. */
    private String apMaterno;

    /** Teléfono del cliente. Debe tener exactamente 10 dígitos numéricos. */
    private String telefono;

    /** Correo del cliente. Debe contener '@' y '.'. */
    private String correo;

    /** Puntos acumulados del cliente. Entero mayor o igual a 0. */
    private int puntos;

    /** Calle de la dirección del cliente. */
    private String calle;

    /** Número exterior de la dirección del cliente. */
    private String numero;

    /** Colonia de la dirección del cliente. */
    private String colonia;

    /** Código postal de la dirección del cliente. 5 dígitos numéricos. */
    private String cp;

    // ------------------------------------------------------------------
    // Constructores
    // ------------------------------------------------------------------

    /**
     * Constructor con datos. Inicializa todos los atributos del cliente.
     *
     * @param idCliente Llave del cliente.
     * @param nombre    Nombre del cliente.
     * @param apPaterno Apellido paterno del cliente.
     * @param apMaterno Apellido materno del cliente.
     * @param telefono  Teléfono de 10 dígitos.
     * @param correo    Correo electrónico.
     * @param puntos    Puntos acumulados (>= 0).
     * @param calle     Calle de la dirección.
     * @param numero    Número exterior.
     * @param colonia   Colonia.
     * @param cp        Código postal de 5 dígitos.
     */
    public Cliente(String idCliente, String nombre, String apPaterno, String apMaterno,
                   String telefono, String correo, int puntos,
                   String calle, String numero, String colonia, String cp) {
        this.idCliente = idCliente;
        this.nombre = nombre;
        this.apPaterno = apPaterno;
        this.apMaterno = apMaterno;
        this.telefono = telefono;
        this.correo = correo;
        this.puntos = puntos;
        this.calle = calle;
        this.numero = numero;
        this.colonia = colonia;
        this.cp = cp;
    }

    /**
     * Constructor vacío. Inicializa los atributos en valores por defecto.
     * Se usa al cargar registros desde el CSV.
     */
    public Cliente() {
        this.idCliente = "";
        this.nombre = "";
        this.apPaterno = "";
        this.apMaterno = "";
        this.telefono = "";
        this.correo = "";
        this.puntos = 0;
        this.calle = "";
        this.numero = "";
        this.colonia = "";
        this.cp = "";
    }

    // ------------------------------------------------------------------
    // Getters y setters
    // ------------------------------------------------------------------

    /** @return Llave del cliente. */
    public String getIdCliente() {
        return idCliente;
    }

    /** @param idCliente Nueva llave del cliente. */
    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;    
    }

    /** @return Nombre del cliente. */
    public String getNombre() { 
        return nombre;
    }

    /** @param nombre Nuevo nombre del cliente. */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /** @return Apellido paterno del cliente. */
    public String getApPaterno() {
        return apPaterno;
    }

    /** @param apPaterno Nuevo apellido paterno. */
    public void setApPaterno(String apPaterno) {
        this.apPaterno = apPaterno;
    }

    /** @return Apellido materno del cliente. */
    public String getApMaterno() {
        return apMaterno;
    }

    /** @param apMaterno Nuevo apellido materno. */
    public void setApMaterno(String apMaterno) {
        this.apMaterno = apMaterno;
    }

    /** @return Teléfono del cliente. */
    public String getTelefono() {
        return telefono;
    }

    /** @param telefono Nuevo teléfono. */
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    /** @return Correo del cliente. */
    public String getCorreo() {
        return correo;
    }

    /** @param correo Nuevo correo. */
    public void setCorreo(String correo) {
        this.correo = correo;
    }

    /** @return Puntos acumulados del cliente. */
    public int getPuntos() {
        return puntos;
    }

    /** @param puntos Nuevos puntos acumulados. */
    public void setPuntos(int puntos) {
        this.puntos = puntos;
    }

    /** @return Calle de la dirección. */
    public String getCalle() {
        return calle;
    }

    /** @param calle Nueva calle. */
    public void setCalle(String calle) {
        this.calle = calle;
    }

    /** @return Número exterior. */
    public String getNumero() {
        return numero;
    }

    /** @param numero Nuevo número exterior. */
    public void setNumero(String numero) {
        this.numero = numero;
    }

    /** @return Colonia. */
    public String getColonia() {
        return colonia;
    }

    /** @param colonia Nueva colonia. */
    public void setColonia(String colonia) {
        this.colonia = colonia;
    }

    /** @return Código postal. */
    public String getCp() {
        return cp;
    }

    /** @param cp Nuevo código postal. */
    public void setCp(String cp) {
        this.cp = cp;
    }

    /**
     * Devuelve la dirección del cliente como una cadena legible.
     * No es un atributo almacenado: se construye al vuelo a partir
     * de los campos planos de dirección.
     *
     * @return Dirección formateada. <Calle> #<Número>, Col. <Colonia>, CP <CódigoPostal>
     */
    public String getDireccion() {
        return calle + " #" + numero + ", Col. " + colonia + ", CP " + cp;
    }

    // ------------------------------------------------------------------
    // Métodos de la interfaz ArchivoCSV
    // ------------------------------------------------------------------

    /**
     * Compara la llave recibida con la llave del cliente.
     *
     * @param llave Llave a buscar.
     * @return true si coincide con idCliente, false en caso contrario.
     */
    @Override
    public boolean consultar(String llave) {
        return this.idCliente != null && this.idCliente.equals(llave);
    }

    /**
     * Actualiza los datos del cliente a partir de otro objeto Cliente.
     * Se usa en la operación de edición.
     *
     * @param o Objeto Cliente con los nuevos datos.
     * @throws IllegalArgumentException Si el objeto no es de tipo Cliente.
     */
    @Override
    public void actualizar(Object o) {
        if (!(o instanceof Cliente)) {
            throw new IllegalArgumentException("El objeto a actualizar no es un Cliente.");
        }
        Cliente c = (Cliente) o;
        this.idCliente = c.getIdCliente();
        this.nombre = c.getNombre();
        this.apPaterno = c.getApPaterno();
        this.apMaterno = c.getApMaterno();
        this.telefono = c.getTelefono();
        this.correo = c.getCorreo();
        this.puntos = c.getPuntos();
        this.calle = c.getCalle();
        this.numero = c.getNumero();
        this.colonia = c.getColonia();
        this.cp = c.getCp();
    }

    /**
     * Devuelve la representación CSV del cliente.
     * El orden de columnas debe coincidir con el encabezado del archivo.
     *
     * @return Línea CSV con los datos del cliente.
     */
    @Override
    public String getCSV() {
        return idCliente + "," + nombre + "," + apPaterno + "," + apMaterno + ","
                + telefono + "," + correo + "," + puntos + ","
                + calle + "," + numero + "," + colonia + "," + cp;
    }

    /**
     * Carga los datos de una línea CSV en este cliente.
     * El orden de columnas debe coincidir con el encabezado del archivo.
     *
     * @param csv Línea CSV con los datos del cliente.
     * @throws IllegalArgumentException Si la línea no tiene el formato esperado.
     */
    @Override
    public void cargar(String csv) {
        String[] partes = csv.split(",");
        if (partes.length != 11) {
            throw new IllegalArgumentException("Línea CSV de Cliente inválida: " + csv);
        }
        try {
            this.idCliente = partes[0].trim();
            this.nombre = partes[1].trim();
            this.apPaterno = partes[2].trim();
            this.apMaterno = partes[3].trim();
            this.telefono = partes[4].trim();
            this.correo = partes[5].trim();
            this.puntos = Integer.parseInt(partes[6].trim());
            this.calle = partes[7].trim();
            this.numero = partes[8].trim();
            this.colonia = partes[9].trim();
            this.cp = partes[10].trim();
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Los puntos deben ser un número entero: " + partes[6]);
        }
    }

    // ------------------------------------------------------------------
    // Validaciones
    // ------------------------------------------------------------------

    /**
     * Valida los datos del cliente antes de agregarlo o editarlo.
     * Lanza una excepción con mensaje claro si algún dato es inválido.
     *
     * @throws IllegalArgumentException Si algún atributo no cumple las reglas.
     */
    public void validar() {
        if (idCliente == null || idCliente.trim().isEmpty()) {
            throw new IllegalArgumentException("El id del cliente no puede estar vacío.");
        }
        if (!idCliente.matches("\\d+")) {
            throw new IllegalArgumentException("El id del cliente debe tener el formato C### (ej. C001).");
        }
        if (nombre == null || nombre.trim().isEmpty()) {
            throw new IllegalArgumentException("El nombre no puede estar vacío.");
        }
        if (apPaterno == null || apPaterno.trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido paterno no puede estar vacío.");
        }
        if (apMaterno == null || apMaterno.trim().isEmpty()) {
            throw new IllegalArgumentException("El apellido materno no puede estar vacío.");
        }
        if (telefono == null || !telefono.matches("\\d{10}")) {
            throw new IllegalArgumentException("El teléfono debe tener exactamente 10 dígitos numéricos.");
        }
        if (correo == null || !correo.contains("@") || !correo.contains(".")) {
            throw new IllegalArgumentException("El correo debe contener '@' y '.'.");
        }
        if (puntos < 0) {
            throw new IllegalArgumentException("Los puntos no pueden ser negativos.");
        }
        if (calle == null || calle.trim().isEmpty()) {
            throw new IllegalArgumentException("La calle no puede estar vacía.");
        }
        if (numero == null || numero.trim().isEmpty()) {
            throw new IllegalArgumentException("El número exterior no puede estar vacío.");
        }
        if (colonia == null || colonia.trim().isEmpty()) {
            throw new IllegalArgumentException("La colonia no puede estar vacía.");
        }
        if (cp == null || !cp.matches("\\d{5}")) {
            throw new IllegalArgumentException("El código postal debe tener exactamente 5 dígitos numéricos.");
        }
    }

    /**
     * Devuelve una representación legible del cliente para mostrarlo en consola.
     *
     * @return Cadena con todos los datos del cliente.
     */
    @Override
    public String toString() {
        return "Cliente {" +
                "idCliente='" + idCliente + '\'' +
                ", nombre='" + nombre + '\'' +
                ", apPaterno='" + apPaterno + '\'' +
                ", apMaterno='" + apMaterno + '\'' +
                ", telefono='" + telefono + '\'' +
                ", correo='" + correo + '\'' +
                ", puntos=" + puntos +
                ", direccion='" + getDireccion() + '\'' +
                '}';
    }
}