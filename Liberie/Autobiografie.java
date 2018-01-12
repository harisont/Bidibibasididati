/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package autobiografie;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author am960030
 */
public class Autobiografie {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Autobiografie.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String url="jdbc:postgresql://localhost/librerie";
        String user="postgres";
        String pwd="postgres";
        Connection conn=null;
        try {
            conn=DriverManager.getConnection(url, user, pwd);
            Statement stmt=conn.createStatement();

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}

