/**
 * Interfas que nos asegura que las clases que la implementen puedan actualizar, 
 * consultar y solicitar su representación en csv para la base de datos.
 */
public interface ArchivoCSV{

    /**
     * Actualiza el los atributos del objeto anfitrión con los del objeto o.
     * @param o el objeto que contiene los nuevos atributos.
     * @throws IllegalArgumentException si el objeto o es null, o si no pertenece a la clase 
     * del objeto que intenta actualizar, o si contiene atributos invalidos;
     */
    public void actualizar(Object o) throws IllegalArgumentException;

    /**
     * Consulta si el objeto anfitrión es al que refiere la llave.
     * @param llave el atributo que se definió como llave en el objeto.
     * @return false si la llave no hace referencia a ese objeto.
     * @return true si la llave corresponde a este objeto.
     */
    public boolean consultar(String llave);

    /**
     * Nos regresa la representación del objeto en formato csv del objeto
     * @return String la cadena que contiene los atributos del objeto separados por comas.
     */
    public String getCSV();

    /**
     * Carga al objeto con los datos obtenidos de un archivo .csv
     * @param csv la representación en cadena del objeto en formato csv.
     * @throws IllegalArgumentException si la cadena csv es invalida.
     */
    public void cargar(String csv) throws IllegalArgumentException;

}