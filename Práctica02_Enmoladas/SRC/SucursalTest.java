public class SucursalTest {
    public static void main(String[] args) {
        System.out.println("Iniciando pruebas para Sucursal...");
        testConstructorYGetters();
        testSetters();
        testValidar();
        testEquals();
        testCSV();
        System.out.println("Todas las pruebas pasaron exitosamente.");
    }

    private static void testConstructorYGetters() {
        Sucursal s = new Sucursal("S001", "Central", "Av. Siempre Viva", "1A", "742", "Springfield", "Estado", "1234567890", "9-18");
        assert "S001".equals(s.getIdSucursal()) : "Error en getIdSucursal";
        assert "Central".equals(s.getNombre()) : "Error en getNombre";
        assert "Av. Siempre Viva".equals(s.getCalle()) : "Error en getCalle";
        assert "1A".equals(s.getNumInterior()) : "Error en getNumInterior";
        assert "742".equals(s.getNumExterior()) : "Error en getNumExterior";
        assert "Springfield".equals(s.getColonia()) : "Error en getColonia";
        assert "Estado".equals(s.getEstado()) : "Error en getEstado";
        assert "1234567890".equals(s.getTelefono()) : "Error en getTelefono";
        assert "9-18".equals(s.getHorarios()) : "Error en getHorarios";
    }

    private static void testSetters() {
        Sucursal s = new Sucursal();
        s.setIdSucursal("S002");
        assert "S002".equals(s.getIdSucursal()) : "Error en setIdSucursal";
    }

    private static void testValidar() {
        Sucursal s = new Sucursal("S001", "Central", "Av", "1", "1", "Col", "Est", "123", "9-18");
        try {
            s.validar();
        } catch (Exception e) {
            assert false : "Validar arrojó una excepción inesperada: " + e.getMessage();
        }

        Sucursal sInvalida = new Sucursal("", "", "", "", "", "", "", "", "");
        try {
            sInvalida.validar();
            assert false : "Validar no detectó una sucursal inválida (ID vacío)";
        } catch (IllegalArgumentException e) {
            // Esperado
        }
    }

    private static void testEquals() {
        Sucursal s1 = new Sucursal("S001", "Central", "Av", "1", "1", "Col", "Est", "123", "9-18");
        Sucursal s2 = new Sucursal("S001", "Central", "Av", "1", "1", "Col", "Est", "123", "9-18");
        Sucursal s3 = new Sucursal("S002", "Central", "Av", "1", "1", "Col", "Est", "123", "9-18");
        
        assert s1.equals(s2) : "Error en equals: deben ser iguales";
        assert !s1.equals(s3) : "Error en equals: deben ser diferentes";
    }

    private static void testCSV() {
        Sucursal s = new Sucursal("S001", "Central", "Av", "1", "1", "Col", "Est", "123", "9-18");
        String csv = s.getCSV();
        assert "S001,Central,Av,1,1,Col,Est,123,9-18".equals(csv) : "Error en getCSV";

        Sucursal s2 = new Sucursal();
        s2.cargar(csv);
        assert s.equals(s2) : "Error en cargar CSV";
    }
}
