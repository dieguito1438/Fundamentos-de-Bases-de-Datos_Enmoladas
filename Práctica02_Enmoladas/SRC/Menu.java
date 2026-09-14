import java.util.LinkedList;
import java.util.Scanner;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

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
                    break;
                case 2: 
                    consultar();
                    break;
                case 3: 
                    editar();
                    break;
                case 4:
                    eliminar();
                    break;
                case 5:
                    System.out.println("Cerrando sesión...");
                    try {
                        guardarClientes();
                        guardarSucursales();
                        guardarPremios();
                        System.exit(0);
                    } catch (Exception e) {
                        System.out.print("No se pudo guardar la información... \nAbortando\n");
                        System.exit(1);
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
     * No puede haber más de un clientes con la misma llave.
     */
    private void agregarCliente(){
        Cliente cliente = crearCliente();
        String llave = cliente.getIdCliente();
        for(ArchivoCSV a : clientes){
            if(a.consultar(llave)){
                System.out.println("No puede haber Id's repetidos... Intente de nuevo");
                return;
            }
        }
        try{
            cliente.validar();
        }catch(IllegalArgumentException iae){
            System.out.println(iae.getMessage());
            System.out.println("Cliente invalido... Abortando.");
            return;
        }
        clientes.add(cliente);
        try{
            guardarClientes();
        }catch(IOException ioe){
            System.out.println("Ocurrio un error al guardar el nuevo cliente en el archivo .csv");
        }
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
     * No puede haber más de una sucursal con la misma llave.
     */
    private void agregarSucursal(){
        Sucursal sucursal = crearSucursal();
        String llave = sucursal.getIdSucursal();
        for(ArchivoCSV a : sucursales){
            if(a.consultar(llave)){
                System.out.println("No puede haber Id's repetidos... Intente de nuevo");
                return;
            }
        }
        try{
            sucursal.validar();
        }catch(IllegalArgumentException iae){
            System.out.println(iae.getMessage());
            System.out.println("Sucursal invalida... Abortando.");
            return;
        }
        sucursales.add(sucursal);
        try{
            guardarSucursales();
        }catch(IOException ioe){
            System.out.println("Ocurrio un error al guardar la nueva sucursal en el archivo .csv.");
        }
    }

    /**
     * Menu para crear una sucursal.
     * @return sucursal la nueva sucursal.
     */
    private Sucursal crearSucursal(){
        String idSucursal = recibirString("Ingrese el Id de la sucursal: ");
        String nombre = recibirString("Ingrese el nombre de la sucursal: ");
        String calle = recibirString("Ingrese la calle de la dirección de la sucursal: ");
        String numInterior = recibirString("Ingrese el número interior de la dirección de la sucursal (n.a si no aplica.): ");
        String numExterior = recibirString("Ingrese el número exterior de la dirección de la sucursal: ");
        String colonia = recibirString("Ingrese la colonia de la dirección de la sucursal: ");
        String estado = recibirString("Ingrese el estado de la dirección de la sucursal: ");
        String telefono = recibirString("Ingrese el telefono de la sucursal: ");
        String horarios = recibirString("Ingrese el horario de atención de la sucursal: ");
        return new Sucursal(idSucursal, nombre, calle, numInterior, 
                            numExterior, colonia, estado, telefono, 
                            horarios);
    }

    /**
     * Método para agregar un premio a la base de datos.
     * No puede haber más de un premio con la misma llave.
     */
    private void agregarPremio(){
        Premio premio = crearPremio();
        String llave = premio.getIdPremio();
        for(ArchivoCSV a : premios){
            if(a.consultar(llave)){
                System.out.println("No puede haber Id's repetidos... intente de nuevo");
                return;
            }
        }
        try{
            premio.validar();
        }catch(IllegalArgumentException iae){
            System.out.println(iae.getMessage());
            System.out.println("Premio invalido... Abortando.");
            return;
        }
        premios.add(premio);
        try{
            guardarPremios();
        }catch(IOException ioe){
            System.out.println("Ocurrio un error al guardar el nuevo premio en el archivo .csv");
        }
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
     * Se le pedirá la llave del Cliente que se va a consultar.
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
     * Se le pedirá la llave de la Sucursal que se va a consultar.
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
     * Se le pedirá la llave del Premio que se va a consultar.
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
     * Se le pedirá la llave del Cliente que se va a editar.
     */
    private void editarCliente(){
        if(clientes.isEmpty()){
            System.out.println("No hay clientes por editar... Registre un nuevo cliente");
            return;
        }
        String llave = recibirString("Ingrese la llave del cliente que desea editar: ");
        ArchivoCSV clienteViejo = null;
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

    /**
     * Método para editar sucursales en la base de datos.
     * Se le pedirá la llave de la Sucursal que se va a editar.
     */
    private void editarSucursal(){
        if(sucursales.isEmpty()){
            System.out.println("No hay sucursales por editar... Registre una nueva sucursal");
            return;
        }
        String llave = recibirString("Ingrese la llave de la sucursal que desea editar: ");
        ArchivoCSV sucursalVieja = null;
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

    /**
     * Método para editar premios de la base de datos.
     * Se le pedirá la llave del Premio que se va a editar.
     */
    private void editarPremio(){
        if(premios.isEmpty()){
            System.out.println("No hay premios por editar... Registre un nuevo premio.");
            return;
        }
        String llave = recibirString("Ingrese la llave del premio que desea editar: ");
        ArchivoCSV premioViejo = null;
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

    /**
     * Método para eliminar clientes de la base de datos.
     * Se le pedirá la llave del Cliente que se va a eliminar.
     */
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

    /**
     * Método para eliminar Sucursales de la base de datos.
     * Se le pedirá la llave de la sucursal que se va a eliminar.
     */
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

    /**
     * Método para eliminar Premios de la base de datos.
     * Se le pedirá la llave del premio que se va a eliminar.
     */
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

    /**
     * Guarda los clientes en el archivo "clientes.csv".
     * @throws IOException si ocurre un error al guardar a los clientes.
     */
    private void guardarClientes() throws IOException{
        try(BufferedWriter out = new BufferedWriter(
                                new OutputStreamWriter(
                                    new FileOutputStream("clientes.csv"), StandardCharsets.UTF_8))){
            for(ArchivoCSV a : clientes){
                out.write(a.getCSV());
                out.newLine();
            }
            System.out.println("Clientes guardados con exito");
        }catch(IOException e){
                throw new IOException("Error al guardar a los clientes de la base de datos");
        }
    }

    /**
     * Guarda las sucursales en el archivo "sucursales.csv".
     * @throws IOException si ocurre un error al guardar las sucursales.
     */
    private void guardarSucursales() throws IOException{
        try(BufferedWriter out = new BufferedWriter(
                                new OutputStreamWriter(
                                    new FileOutputStream("sucursales.csv"), StandardCharsets.UTF_8))){
            for(ArchivoCSV a : sucursales){
                out.write(a.getCSV());
                out.newLine();
            }
            System.out.println("Sucursales guardadas con exito");
        }catch(IOException e){
                throw new IOException("Error al guardar a las sucursales de la base de datos");
        }
    }

    /**
     * Guarda los premios en el archivo "premios.csv".
     * @throws IOException si ocurre un error al guardar los premios.
     */
    private void guardarPremios() throws IOException{
        try(BufferedWriter out = new BufferedWriter(
                                     new OutputStreamWriter(
                                         new FileOutputStream("premios.csv"), StandardCharsets.UTF_8))){
            for(ArchivoCSV a : premios){
                out.write(a.getCSV());
                out.newLine();
            }
            System.out.println("Premios guardados con exito");
        }catch(IOException e){
                throw new IOException("Error al guardar a los premios de la base de datos");
        }
    }

    /**
     * Carga los registros de la base de datos.
     * Carga del archivo "clientes.csv" a los clientes.
     * Carga del archivo "sucursales.csv" a las sucursales.
     * Carga del archivo "premios.csv" a los premios.
     * Si alguno de estos no existe solamente se creará al momento de crear nuevos registros.
     */
    private void cargar(){
       try(BufferedReader in = new BufferedReader(
                                   new InputStreamReader(
                                       new FileInputStream("clientes.csv")))){
            String linea;
            while((linea = in.readLine()) != null){
                try{
                    Cliente cliente = new Cliente();
                    cliente.cargar(linea);
                    clientes.add(cliente);
                }catch(IllegalArgumentException iae){
                    System.out.println("Error al cargar un cliente... Eliminando");
                }
            }
        }catch(FileNotFoundException fnte){
            System.out.println("No se encontró el archivo clientes.csv, se creará al finalizar la sesión.");
        }catch(IOException ioe){
            System.out.println("Ocurrio un error al cargar los clientes de la base de datos.");
        }
        try(BufferedReader in = new BufferedReader(
                                    new InputStreamReader(
                                        new FileInputStream("sucursales.csv")))){
            String linea;
            while((linea = in.readLine()) != null){
                try{
                    Sucursal sucursal = new Sucursal();
                    sucursal.cargar(linea);
                    sucursales.add(sucursal);
                }catch(IllegalArgumentException iae){
                    System.out.println("Error al cargar una sucursal... Eliminando");
                }
            }
        }catch(FileNotFoundException fnte){
            System.out.println("No se encontró el archivo sucursales.csv, se creará al finalizar la sesión.");
        }catch(IOException ioe){
            System.out.println("Ocurrio un error al cargar las sucursales de la base de datos.");
        }
        try(BufferedReader in = new BufferedReader(
                                   new InputStreamReader(
                                       new FileInputStream("premios.csv")))){
            String linea;
            while((linea = in.readLine()) != null){
                try{
                    Premio premio = new Premio();
                    premio.cargar(linea);
                    premios.add(premio);
                }catch(IllegalArgumentException iae){
                    System.out.println("Error al cargar un premio... Eliminando");
                }
            }
        }catch(FileNotFoundException fnte){
            System.out.println("No se encontró el archivo premios.csv, se creará al finalizar la sesión.");
        }catch(IOException ioe){
            System.out.println("Ocurrio un error al cargar los premios de la base de datos.");
        }
    }

}