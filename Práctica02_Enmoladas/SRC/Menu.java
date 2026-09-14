import java.util.LinkedList;
import java.util.Scanner;

/**
 * Clase Menu.
 * Se encarga de la interacción con el usuario.
 */
public class Menu{

    /** Lista de clientes de la base de datos. */
    private LinkedList<ArchivoCSV> clientes;
    /** Lista de premios de la base de datos. */
    private LinkedList<ArchivoCSV> premios;
    /** Lista de sucursales de la base de datos. */
    private LinkedList<ArchivoCSV> sucursales;
    /** Scanner para ingresar los valores del usuario. */
    private Scanner sc;

    /**
     * Constructor vacio.
     */
    public Menu(){
        this.clientes = new LinkedList<>();
        this.premios = new LinkedList<>();
        this.sucursales = new LinkedList<>();
        this.sc = new Scanner(System.in);
    }

    /** 
     * Inicia la interacción con el cliente
     * Imprime un mensaje de bienvenido
     * Carga los registros de los archivos csv si existen
    */
    public void inicio(){
        System.out.println("Práctica 2");
        System.out.println("Enmoladas");
        cargar();
        menu();
    }

    /**
     * Menú de interacción con el usuario.
     * 1. Agregar.
     * 2. Consultar.
     * 3. Editar.
     * 4. Eliminar.
     * 5. Cerrar.
     */
    private void menu(){
        String[] mensajes = {"Agregar", "Consultar", "Editar", "Eliminar", "Cerrar"};
        while(true){
            int opcion = decidirOpcion(mensajes);
            switch(opcion){
                case 1: 
                    agregar();
                case 2: 
                    consultar();
                case 3: 
                    editar();
                case 4:
                    eliminar();
                case 5:
                    System.out.println("Cerrando sesión...");
                    try {
                        guardarClientes();
                        guardarSucursales();
                        guardarPremios();
                        sc.close();
                        System.exit(1);
                    } catch (Exception e) {
                        System.out.print("No se pudo guardar la información... \nAbortando\n");
                    }
                default:
                    System.out.println("Enmoladas :)");
            }
        }
    }

    /**
     * Imprime una lista de mensajes entre las cuales el usuario debe de decidir una opción.
     * @param mensajes la lista de mensajes a imprimir.
     * @return la selección del usuario entre los elementos de la lista.
     */
    private int decidirOpcion(String[] mensajes){
        int i = 1;
        for(String m : mensajes){
            System.out.print(String.format("%d. %s\n", i, m));
            i++;
        }
        return recibirInt(1, mensajes.length);
    }

    /**
     * Recibe y filtra la información ingresada por el usuario.
     * @param mensaje mensaje relacionado a la información que se le pide al usuario ingresar.
     * @return String la cadena verificada, no puede ser nula ni vacia.
     */
    private String recibirString(String mensaje){
        String entrada = "";
        while(true){
            System.out.print(mensaje);
            entrada = sc.nextLine();
            if(entrada == null || entrada.equals("")){
                System.out.println("Opción invalida, intente de nuevo");
                continue;
            }
        }

    }

    /**
     * Recibe un indice entre el valor i y el valor f.
     * @param i el valor mínimo que puede ingresar el usuario.
     * @param f el valor máximo que puede ingresar el usuario.
     * @return int el valor verificado ingresado por el usuario entre los valores i y f.
     */
    private int recibirInt(int i, int f){
        while (true) {    
            try {
                int opcion = Integer.parseInt(recibirString("Ingrese su opción: "));
                if(opcion >= i && opcion <= f)
                    return opcion;
                else
                    System.out.println("La opción ingresada no pertenece a las opciones disponibles, intente de nuevo.");
            } catch (NumberFormatException nfe) {
                System.out.println("La opción ingresada no es un número, intente de nuevo.");
            }
        }
    }

    /**
     * Menú de selección para agregar entidades a la base de datos.
     * 1. Agregar Clientes.
     * 2. Agregar Sucursales.
     * 3. Agregar Premios.
     */
    private void agregar(){
        String[] mensajes = {"Agregar Cliente", "Agregar Sucursal", "Agregar Premio"};
        int opcion = decidirOpcion(mensajes);
        switch(opcion){
            case 1:
                agregarCliente();
                return;
            case 2: 
                agregarSucursal();
                return;
            case 3:
                agregarPremio();
                return;
            default:
                System.out.println("No deberias de haber caido en esta opción...");
        }
    }

    /**
     * Menú de selección para consultar entidades de la base de datos.
     * 1. Consultar Clientes.
     * 2. Consultar Sucursales.
     * 3. Consultar Premios.
     */
    private void consultar(){
        String[] mensajes = {"Consultar Cliente", "Consultar Sucursal", "Consultar Premio"};
        int opcion = decidirOpcion(mensajes);
        switch(opcion){
            case 1:
                consultarCliente();
                return;
            case 2: 
                consultarSucursal();
                return;
            case 3:
                consultarPremio();
                return;
            default:
                System.out.println("No deberias de haber caido en esta opción...");
        }
    }

    /**
     * Menú de selección para edición de entidades en la base de datos.
     * 1. Editar Clientes.
     * 2. Editar Sucursales.
     * 3. Editar Premios.
     */
    private void editar(){
        String[] mensajes = {"Editar Cliente", "Editar Sucursal", "Editar Premio"};
        int opcion = decidirOpcion(mensajes);
        switch(opcion){
            case 1:
                editarCliente();
                return;
            case 2: 
                editarSucursal();
                return;
            case 3:
                editarPremio();
                return;
            default:
                System.out.println("No deberias de haber caido en esta opción...");
        }
    }

    /**
     * Menú de selección para la eliminación de entidades en la base de datos.
     * 1. Eliminar Clientes.
     * 2. Eliminar Sucursales.
     * 3. Eliminar premios.
     */
    private void eliminar(){
        String[] mensajes = {"Eliminar Cliente", "Eliminar Sucursal", "Eliminar Premio"};
        int opcion = decidirOpcion(mensajes);
        switch(opcion){
            case 1:
                eliminarCliente();
                return;
            case 2: 
                eliminarSucursal();
                return;
            case 3:
                eliminarPremio();
                return;
            default:
                System.out.println("No deberias de haber caido en esta opción...");
        }
    }

    /**
     * Método para agregar un cliente a a base de datos.
     */
    private void agregarCliente(){
        Cliente cliente = crearCliente();
        try{
            cliente.validar();
        }catch(IllegalArgumentException iae){
            System.out.println(iae.getMessage());
            System.out.println("Cliente invalido... Abortando.");
            return;
        }
        clientes.add(cliente);
    }

    /**
     * Menu para crear un cliente.
     * @return cliente el nuevo cliente.
     */
    private Cliente crearCliente(){
        String idCliente = recibirString("Ingrese el ID del cliente: ");
        String nombre = recibirString("Ingrese el nombre del cliente: ");
        String apPaterno = recibirString("Ingrese el apellido paterno del cliente: ");
        String apMaterno = recibirString("Ingrese el apellido materno del cliente: ");
        String telefono = recibirString("Ingrese el número de telefono del cliente: ");
        String correo = recibirString("Ingrese el correo electronico del cliente: ");
        int puntos = 0;
        String calle = recibirString("Ingrese la calle del domicilio del cliente: ");
        String numero = recibirString("Ingrese el número exterior del domicilio del cliente: ");
        String colonia = recibirString("Ingrese la colonia de la dirección del cliente: ");
        String cp = recibirString("Ingrese el codigo postal del cliente: ");
        return new Cliente(idCliente, nombre, apPaterno, apMaterno, telefono, correo, puntos, calle, numero, colonia, cp);
    }

    /**
     * Método para agregar una sucursal a la base de datos.
     */
    private void agregarSucursal(){
        Sucursal sucursal = crearSucursal();
        try{
            sucursal.validar()
        }catch(IllegalArgumentException iae){
            System.out.println(iae.getMessage());
            System.out.println("Sucursal invalida... Abortando.");
            return;
        }
        sucursales.add(sucursal);
    }

    /**
     * Menu para crear una sucursal.
     * @return sucursal la nueva sucursal.
     */
    private Sucursal crearSucursal(){
        return new Sucursal();
    }

    /**
     * Método para agregar un premio a la base de datos.
     */
    private void agregarPremio(){
        Premio premio = crearPremio();
        try{
            premio.validar();
        }catch(IllegalArgumentException iae){
            System.out.println(iae.getMessage());
            System.out.println("Premio invalido... Abortando.");
            return;
        }
        premios.add(premio);
    }

    /**
     * Menu para crear un premio.
     * @return premio el nuevo premio.
     */
    private Premio crearPremio(){
        return new Premio();
    }

    /**
     * Método para consultar clientes en la base de datos.
     */
    private void consultarCliente(){
        if(clientes.isEmpty()){
            System.out.println("No hay clientes registrados... Registre un nuevo cliente.");
            return;
        }
        String llave = recibirString("Ingrese la llave del cliente a consultar: ");
        for(ArchivoCSV a: clientes){
            if(a.consultar(llave))
                System.out.println(a);
                return;
        }
        System.out.println("Cliente con llave " + llave + " no encontrado");
    }

    /**
     * Método para consultar sucursales en la base de datos.
     */
    private void consultarSucursal(){
        if(sucursales.isEmpty()){
            System.out.println("No hay sucursales registradas... Registre una nueva sucursal.");
            return;
        }
        String llave = recibirString("Ingrese la llave de la sucursal que desea consultar: ");
        for(ArchivoCSV a : sucursales){
            if(a.consultar(llave)){
                System.out.println(a);
                return;
            }
        }
        System.out.println("Sucursal con llave " + llave + " no encontrado");
    }

    /**
     * Método para consultar premios en la base de datos.
     */
    private void consultarPremio(){
        if(premios.isEmpty()){
            System.out.println("No hay premios registrados... Registre un nuevo premio.");
            return;
        }
        String llave = recibirString("Ingrese la llave del premio que quiere consultar: ");
        for(ArchivoCSV a : premios){
            if(a.consultar(llave)){
                System.out.println(a);
                return;
            }
        }
        System.out.println("Premio con llave " + llave + " no encontrado.");
    }

    /**
     * Método para editar clientes de la base de datos.
     */
    private void editarCliente(){
        if(clientes.isEmpty()){
            System.out.println("No hay clientes por editar... Registre un nuevo cliente");
            return;
        }
        String llave = recibirString("Ingrese la llave del cliente que desea editar: ");
        ArchivoCSV clienteViejo;
        for(ArchivoCSV a : clientes){
            if(a.consultar(llave))
                clienteViejo = a;
        }
        if(clienteViejo == null){
            System.out.println("Cliente con llave " + llave + " no encontrado.");
            return;
        }
        System.out.println("~ Ingrese los nuevos valores del cliente ~");
        Cliente clienteNuevo = crearCliente();
        clienteViejo.actualizar((Object) clienteNuevo);
        }
    }

    private void editarSucursal(){
        if(sucursales.isEmpty()){
            System.out.println("No hay sucursales por editar... Registre una nueva sucursal");
            return;
        }
        String llave = recibirString("Ingrese la llave de la sucursal que desea editar: ");
        ArchivoCSV sucursalVieja;
        for(ArchivoCSV a : sucursales){
            if(a.consultar(llave))
                sucursalVieja = a;
        }
        if(sucursalVieja == null){
            System.out.println("Sucursal con llave " + llave + " no encontrada.");
            return;
        }
        System.out.println("~ Ingrese los nuevos valores de la sucursal ~");
        Sucursal sucursalNueva = crearSucursal();
        sucursalVieja.actualizar((Object) sucursalNueva);
    }

    private void editarPremio(){
        if(premios.isEmpty()){
            System.out.println("No hay premios por editar... Registre un nuevo premio.");
            return;
        }
        String llave = recibirString("Ingrese la llave del premio que desea editar: ");
        ArchivoCSV premioViejo;
        for(ArchivoCSV a : premios){
            if(a.consultar(llave))
                premioViejo = a;
        }
        if(premioViejo == null){
            System.out.println("Premio con llave " + llave + " no encontrado.");
            return;
        }
        System.out.println("~ Ingrese los nuevos valores del premio ~");
        Premio premioNuevo = crearPremio();
        premioViejo.actualizar((Object) premioNuevo);
    }

    private void eliminarCliente(){
        if(clientes.isEmpty()){
            System.out.println("No hay clientes por eliminar... Registre un nuevo cliente.");
            return;
        }
        String llave = recibirString("Ingrese la llave del cliente que desea eliminar: ");
        for(ArchivoCSV a : clientes){
            if(a.consultar(llave))
                System.out.println("Esta seguro de querer eliminar al cliente?: ");
                System.out.println(a);
                String[] opciones = {"Si, No"};
                int opcion = decidirOpcion(opciones);
                switch(opcion){
                    case 1:
                        clientes.remove(a);
                        return;
                    case 2: 
                        System.out.println("Abortando...");
                        return;
                    default: 
                        System.out.println("No deberias de haber caido en esta opción...");
                }
        }
        System.out.println("Cliente con llave " + llave + " no encontrado.");
    }

    private void eliminarSucursal(){
        if(sucursales.isEmpty()){
            System.out.println("No hay sucursales por eliminar... Registre una nueva sucursal.");
            return;
        }
        String llave = recibirString("Ingrese la llave de la sucursal que desea eliminar: ");
        for(ArchivoCSV a : sucursales){
            if(a.consultar(llave)){
                System.out.println("Esta seguro de querer eliminar la sucursal?: ");
                System.out.println(a);
                String[] opciones = {"Si", "No"};
                int opcion = decidirOpcion(opciones);
                switch(opcion){
                    case 1:
                        sucursales.remove(a);
                        return;
                    case 2:
                        System.out.println("Abortando...");
                        return;
                    default:
                        System.out.println("No deberias de haber caido en esta opción...");
                }
            }
        }
        System.out.println("Sucursal con llave " + llave + " no encontrada.");
    }

    private void eliminarPremio(){
        if(premios.isEmpty()){
            System.out.println("No hay premios por eliminar... Registre una nueva sucursal.");
            return;
        }
        String llave = recibirString("Ingrese la llave del premio que desea eliminar");
        for(ArchivoCSV a : premios){
            if(a.consultar(llave)){
                System.out.println("Esta seguro de querer eliminar el premio?: ");
                System.out.println(a);
                String[] opciones = {"Si", "No"};
                int opcion = decidirOpcion(opciones);
                switch(opcion){
                    case 1:
                        premios.remove(a);
                        return;
                    case 2:
                        System.out.println("Abortando...");
                        return;
                    default:
                        System.out.println("No deberias de haber caido en esta opción...");
                }
            }
        }
        System.out.println("Premio con llave " + llave + " no encontrado");
    }

    private void guardarClientes(){

    }

    private void guardarSucursales(){

    }

    private void guardarPremios(){

    }

    private void cargar(){
       
    }

}