/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pruebainicial;

import java.io.File;
import javax.swing.JOptionPane;

/**
 *
 * @author walterrodriguez
 */
public class PruebaInicial {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        System.out.println("Hola mundo!");
        
        
        String path = "/Users/walterrodriguez/NetBeansProjects/PruebaInicial/src/pruebainicial/Lexer.flex";
        JOptionPane.showMessageDialog(null, "Iniciamos leyendo archivo: \n" + path );
        
        createLexer(path);
        
    }
    
    public static void createLexer(String ruta){
        File archivo = new File(ruta);
        jflex.Main.generate(archivo);
    }
    
}
