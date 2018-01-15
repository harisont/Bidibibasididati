/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package narrativa.java;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author am960030
 */
public class NarrativaJava { 
   static {
      try {
         // register the driver with DriverManager
         Class.forName("org.postgresql.Driver").newInstance();
      } catch (Exception e) {
         e.printStackTrace();
      }
    }
    public static void main(String[] args) {
        Connection conn=null;
        String url = "jdbc:postgresql://localhost/postgres";
        String user = "postgres";
        String pwd = "postgres";
       try {
           conn = DriverManager.getConnection(url, user, pwd);
           Statement stmt= conn.createStatement();
           stmt.executeUpdate("SET search_path TO librerie;");
           stmt.executeUpdate("DROP TABLE IF EXISTS libri_narrativa");
           stmt.executeUpdate("CREATE TABLE libri_narrativa"
                   + "(codice int REFERENCES libri(codice) PRIMARY KEY, "
                   + "editore int REFERENCES editori(codice));");
           ResultSet rs = stmt.executeQuery("SELECT codice, editore FROM libri WHERE genere='Narrativa';");
           PreparedStatement ps= conn.prepareStatement("INSERT INTO libri_narrativa VALUES (?, ?);");
           while(rs.next()) {
               ps.setInt(1, rs.getInt(1));
               ps.setInt(2, rs.getInt(2));
               ps.executeUpdate();
           }
           stmt.close();
           rs.close();
           ps.close();
           conn.close();
       } catch (Exception ex) {
           Logger.getLogger(NarrativaJava.class.getName()).log(Level.SEVERE, null, ex);
       }
    }
}
