/**
 * Representa un Premio dentro del centro de entretenimiento familiar Puella Game.
 * Implementa ArchivoCSV para integrarse al menú del sistema.
 *
 * Formato CSV:
 * idPremio,nombre,categoria,rangoEdad,valorAproximado,puntosNecesarios
 *
 * @author Integrante 3
 * @version 1.0
 */
public class Premio implements ArchivoCSV{


    /** LLave de la Entidad  */
    private String idPremio;

    /**Nombre del premio. No puede ser vacio */
    private String nombre;

    /**Categoria del Premio.No puede ser vacio */
    private CategoriaPremio categoria;

    /** Rango de edad de la persona para recibir Premio. No puede ser vacio */
    private RangoEdad rangoEdad;

    /**Valor monetario ddel costo aproximado del premio. Valor no vacio */
    private double valorAproximado;

    /** Cantidad de Puntos cara canejar un premio. Valor no vacio*/
    private int puntosNecesarios;

    /**
     * CategoriaPremio
     * Premios Bajos De 20 a 1,000 puntos &lt;juguetes simples, golosinas, etc&gt;.
     *  Premios Medios: De 1,001 a 3,999 puntos &lt;peluches gigantes, artículos deportivos, juguetes tipo lego,etc&gt;.
     * Premios Grandes: De 4,000 a +10,000 puntos &lt;artículos de marca, electrónicos pequeños, dispositivos electónicos, etc&gt;.
     * 
     */
    public enum CategoriaPremio{
        BAJO,
        MEDIO,
        GRANDE
    }

    /**
     * RangoEdad
     * Estos premios se divide seg ́un la edad, considerando
     * los siguientes rangos:
     * 3-12 Infantil
     * 3-17 Juvenil
     * 18+ Adulto
     */
    public enum RangoEdad{
        INFANTIL,
        JUVENIL,    
        ADULTO
    }

    // ------------------------------------------------------------------
    // Constructores
    // ------------------------------------------------------------------



    /**
     * @param idPremio Llave del Premio
     * @param nombre Nombre del premio
     * @param categoria Categoria del premio
     * @param rangoEdad Rango del edad para el canje del Premio
     * @param valorAproximado Valor monetario aproximado del premio
     * @param puntosNecesarios Puntos necesarios para canjear el premio
     */
    public Premio(
        String idPremio,
        String nombre,
        CategoriaPremio categoria,
        RangoEdad rangoEdad,
        double valorAproximado,
        int puntosNecesarios) {

        this.idPremio = idPremio;
        this.nombre = nombre;
        this.categoria = categoria;
        this.rangoEdad = rangoEdad;
        this.valorAproximado = valorAproximado;
        this.puntosNecesarios = puntosNecesarios;
    }

    public Premio() {
        this.idPremio = null;
        this.nombre = null;
        this.categoria = null;
        this.rangoEdad = null;
        this.valorAproximado = 0;
        this.puntosNecesarios = 0;
    }

    /** 
     * @return Llave del Premio
     */
    public String getIdPremio() {
        return idPremio;
    }

    /**
     * @return Nombre del premio
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * @return Categoria del premio
     */
    public CategoriaPremio getCategoria() {
        return categoria;
    }

    /**
     * @return Rango del edad para el canje del Premio
     */
    public RangoEdad getRangoEdad() {
        return rangoEdad;
    }

    /**
     * @return Valor monetario aproximado del premio
     */
    public double getValorAproximado() {
        return valorAproximado;
    }

    /**
     * @return Puntos necesarios para canjear el premio
     */
    public int getPuntosNecesarios() {
        return puntosNecesarios;
    }




    /**
     * @param idPremio Llave del Premio
     */
    public void setIdPremio(String idPremio) {
        this.idPremio = idPremio;
    }

    /**
     * @param nombre  Nombre del premio
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     * @param categoria Categoria del premio
     */
    public void setCategoria(CategoriaPremio categoria) {
        this.categoria = categoria;
    }

    /**
     * @param rangoEdad Rango del edad para el canje del Premio
     */
    public void setRangoEdad(RangoEdad rangoEdad) {
        this.rangoEdad = rangoEdad;
    }

    /**
     * @param valorAproximado Valor monetario aproximado del premio
     */
    public void setValorAproximado(double valorAproximado) {
        this.valorAproximado = valorAproximado;
    }

    /**
     * @param puntosNecesarios Puntos necesarios para canjear el premio
     */
    public void setPuntosNecesarios(int puntosNecesarios) {
        this.puntosNecesarios = puntosNecesarios;
    }

    /**
     * @param llave
     * @return
     */
    @Override
    public boolean consultar(String llave) {
    return this.idPremio.equals(llave);
    }
    @Override
    public void actualizar(Object o) {
    if (!(o instanceof Premio)) {
        throw new IllegalArgumentException(
            "El objeto a actualizar no es un Premio."
        );
    }

    Premio p = (Premio) o;

    this.idPremio = p.getIdPremio();
    this.nombre = p.getNombre();
    this.categoria = p.getCategoria();
    this.rangoEdad = p.getRangoEdad();
    this.valorAproximado = p.getValorAproximado();
    this.puntosNecesarios = p.getPuntosNecesarios();
    }
    @Override
    public String getCSV() {
        return idPremio + "," +
           nombre + "," +
           categoria + "," +
           rangoEdad + "," +
           valorAproximado + "," +
           puntosNecesarios;
    }
    @Override
    public void cargar(String csv) {
        String[] partes = csv.split(",");

        if (partes.length != 6) {
            throw new IllegalArgumentException(
                "Línea CSV de Premio inválida: " + csv);
            }

        this.idPremio = partes[0].trim();
        this.nombre = partes[1].trim();
        this.categoria = CategoriaPremio.valueOf(partes[2].trim());
        this.rangoEdad = RangoEdad.valueOf(partes[3].trim());
        this.valorAproximado = Double.parseDouble(partes[4].trim());
        this.puntosNecesarios = Integer.parseInt(partes[5].trim());

        this.validar();
    }

    public  void validar() {
    if (idPremio == null || idPremio.trim().isEmpty()) {
        throw new IllegalArgumentException(
            "El id del premio debe ser mayor que 0."
        );
    }

    if (nombre == null || nombre.trim().isEmpty()) {
        throw new IllegalArgumentException(
            "El nombre del premio no puede estar vacío."
        );
    }

    if (categoria == null) {
        throw new IllegalArgumentException(
            "La categoría del premio no puede ser nula."
        );
    }

    if (rangoEdad == null) {
        throw new IllegalArgumentException(
            "El rango de edad no puede ser nulo."
        );
    }

    if (valorAproximado < 0) {
        throw new IllegalArgumentException(
            "El valor aproximado no puede ser negativo."
        );
    }

    if (puntosNecesarios < 20) {
        throw new IllegalArgumentException(
            "El premio debe requerir al menos 20 puntos."
        );
    }
}
    /** evuelve una representación legible del premio
     *  para mostrarlo en consola.
     *
     * @return Cadena con todos los datos del Premio.
     */
    @Override
    public String toString() {
        return "Premio{" +
                "idPremio=" + idPremio +
                ", nombre='" + nombre + '\'' +
                ", categoria=" + categoria +
                ", rangoEdad=" + rangoEdad +
                ", valorAproximado=" + valorAproximado +
                ", puntosNecesarios=" + puntosNecesarios +
                '}';
    }

}