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
     * Menu de interacción con el usuario.
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
     * Menu de selección para agregar entidades a la base de datos.
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
     * Menu de selección para consultar entidades de la base de datos.
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
     * Menu de selección para edición de entidades en la base de datos.
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
     * Menu de selección para la eliminación de entidades en la base de datos.
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

    private void agregarCliente(){
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
        Cliente cliente = new Cliente(idCliente, nombre, apPaterno, apMaterno, 
                                      telefono, correo, puntos, calle, numero, 
                                      colonia, cp);
        try{
            cliente.validar();
        }catch(IllegalArgumentException iae){
            System.out.println(iae.getMessage());
            System.out.println("Cliente invalido... Abortando.");
            return;
        }
        clientes.add(cliente);
    }

    private void agregarSucursal(){

    }

    private void agregarPremio(){
    }

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

    private void editarCliente(){
        
    }

    private void editarSucursal(){

    }

    private void editarPremio(){

    }

    private void eliminarCliente(){

    }

    private void eliminarSucursal(){

    }

    private void eliminarPremio(){

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