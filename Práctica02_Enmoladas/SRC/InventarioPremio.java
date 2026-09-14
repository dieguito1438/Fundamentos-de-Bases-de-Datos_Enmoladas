public class InventarioPremio implements ArchivoCSV {


    /**Identificador del premio */
    private int idPremio;

    /**Identificador de la sucursal */
    private int idSucursal;
    
    /**Cantidad de un Premio disponible para alguna sucursal */
    private int cantidadDisponible;

    // Constructor vacío para cargar desde CSV
    public InventarioPremio() {
    }

    // Constructor normal
    /**
     * @param idPremio Identificador del premio 
     * @param idSucursal Identificador de la sucursal
     * @param cantidadDisponible Cantidad de un Premio disponible para alguna sucursal
     */
    public InventarioPremio(
            int idPremio,
            int idSucursal,
            int cantidadDisponible) {

        this.idPremio = idPremio;
        this.idSucursal = idSucursal;
        this.cantidadDisponible = cantidadDisponible;
    }

    // Getters

    /**
     * @return Identificador del premio 
     */
    public int getIdPremio() {
        return idPremio;
    }

    /**
     * @return Identificador de la sucursal
     */
    public int getIdSucursal() {
        return idSucursal;
    }

    /**
     * @return Cantidad de un Premio disponible para alguna sucursal
     */
    public int getCantidadDisponible() {
        return cantidadDisponible;
    }

    // Setters

    /**
     * @param idPremio Identificador del premio
     */
    public void setIdPremio(int idPremio) {
        this.idPremio = idPremio;
    }

    /**
     * @param idSucursal Identificador de la sucursal
     */
    public void setIdSucursal(int idSucursal) {
        this.idSucursal = idSucursal;
    }

    /**
     * @param cantidadDisponible Cantidad de un Premio disponible para alguna sucursal
     */
    public void setCantidadDisponible(int cantidadDisponible) {
        this.cantidadDisponible = cantidadDisponible;
    }

    // Métodos de ArchivoCSV

    /**
     * @param llave llave de consolta para la tabla de cedes
     * @return
     */
    @Override
    public boolean consultar(String llave) {
        return this.idPremio == Integer.parseInt(llave);
    }

    /**
     * @param o object que se remplaza su posicion
     */
    @Override
    public void actualizar(Object o) {
        if (!(o instanceof InventarioPremio)) {
            throw new IllegalArgumentException(
                "El objeto a actualizar no es un InventarioPremio."
            );
        }

        InventarioPremio i = (InventarioPremio) o;

        this.idPremio = i.getIdPremio();
        this.idSucursal = i.getIdSucursal();
        this.cantidadDisponible = i.getCantidadDisponible();
    }

    /**
     * @return formato de el archivo csv
     */
    @Override
    public String getCSV() {
        return idPremio + "," +
               idSucursal + "," +
               cantidadDisponible;
    }

    /**
     * @param csv formato csv que es regresadoa a objeto
     */
    @Override
    public void cargar(String csv) {
        String[] partes = csv.split(",");

        if (partes.length != 3) {
            throw new IllegalArgumentException(
                "Línea CSV de InventarioPremio inválida: " + csv
            );
        }

        this.idPremio = Integer.parseInt(partes[0].trim());
        this.idSucursal = Integer.parseInt(partes[1].trim());
        this.cantidadDisponible = Integer.parseInt(partes[2].trim());
    }

    /**  evuelve una representación legible de tabla que muestra cantidad de un premio por sucursal 
     *  para mostrarlo en consola.
     *
     * @return Cadena con los datos un local seleccionado
     */
    @Override
    public String toString() {
        return "InventarioPremio {" +
                "idPremio=" + idPremio +
                ", idSucursal=" + idSucursal +
                ", cantidadDisponible=" + cantidadDisponible +
                '}';
    }
}