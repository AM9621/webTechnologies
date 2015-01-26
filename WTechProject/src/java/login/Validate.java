/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package login;

import java.sql.*;

public class Validate
 {
 
     public static boolean checkUser(String email,String pass) 
     {
      boolean st =false;
      try{

	 //loading driver 
         Class.forName("com.mysql.jdbc.Driver");

 	 //creating connection with the database 
         Connection con=DriverManager.getConnection
                        ("jdbc:mysql://localhost:3306/repo_course","root","yourpassword");
         PreparedStatement ps =con.prepareStatement
                             ("select * from register where email=? and pass=md5(?)");
         ps.setString(1, email);
         ps.setString(2, pass);
         
         ResultSet rs = ps.executeQuery();
         st = rs.next();
        
      }catch(Exception e)
      {
          e.printStackTrace();
      }
         return st;                 
  }   
}
