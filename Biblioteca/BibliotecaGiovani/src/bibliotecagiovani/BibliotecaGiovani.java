/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bibliotecagiovani;

import java.sql.*;
import java.io.*;
import java.util.*;

class BibliotecaGiovani {

   static {
      try {
         // register the driver with DriverManager
         Class.forName("org.postgresql.Driver").newInstance();
      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   public static void main(String argv[]) {
      Connection conn = null;
	try{


            // Connessione al DB
            String url = "jdbc:postgresql://127.0.0.1/postgres";
            String userid = "postgres";
            String passwd = "postgres";
            conn = DriverManager.getConnection(url, userid, passwd);

            System.out.println("Pronti, partenza, via");

            Statement stmt = conn.createStatement(); //Oggetto che consente di eseguire instruzioni SQL

            // Eliminazione eventuali schemi precedenti
            stmt.executeUpdate("DROP SCHEMA IF EXISTS biblioteca_giovani CASCADE");

            // Creazione di schemi e tabelle
            stmt.executeUpdate("CREATE SCHEMA biblioteca_giovani");
            stmt.executeUpdate("CREATE TABLE biblioteca_giovani.libri_teen(isbn varchar(13) PRIMARY KEY, titolo varchar(50), autore varchar(50))");
          
            // Esecuzione query 
            ResultSet rs = stmt.executeQuery("SELECT libro.isbn, libro.titolo, libro.autore "
                    + "FROM biblioteca.libro NATURAL JOIN biblioteca.ha_letto JOIN biblioteca.socio ON biblioteca.socio.id=biblioteca.ha_letto.socio "
                    + "WHERE eta >= 13 AND eta <= 19 "
                    + "GROUP BY libro.ISBN, libro.titolo, libro.autore "
                    + "HAVING COUNT(*) > 1");
            
            // Utilizzo del risultato per il popolamento della tabella libri_teen
            PreparedStatement ps = conn.prepareStatement("INSERT INTO biblioteca_giovani.libri_teen VALUES (?, ?, ?)"); //Evita code injection
            while(rs.next()) {
                String isbn = rs.getString(1);
                String titolo = rs.getString(2);
                String autore = rs.getString(3);
                ps.setString(1, isbn);
                ps.setString(2, titolo);
                ps.setString(3, autore);
                ps.executeUpdate();
            }
            
            // Stampa su file
            PrintWriter pw = new PrintWriter("teenbib.txt");
            pw.println("ISBN\t\t\t titolo \t\t\t\t autore");
            pw.println("======================================================");
            rs = stmt.executeQuery("SELECT * FROM biblioteca_giovani.libri_teen");
            while (rs.next()) {
                String ISBN = rs.getString(1);
                String titolo = rs.getString(2);
                String autore = rs.getString(3);
                pw.println(String.format("%s\t%s\t%s\t", ISBN, titolo, autore));
            }
            
            // Chiusura oggetti
            System.out.println("...chiudo tutto!");
            stmt.close();
            ps.close();
            rs.close();
            pw.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
   }
}


