/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package upload;

/**
 *
 * @author root_
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author root_
 */
public class checkFile {
    public static boolean exists(String filename) 
    {
        boolean st =false;
        try{

            //loading driver 
            Class.forName("com.mysql.jdbc.Driver");

            //creating connection with the database 
            Connection con=DriverManager.getConnection
                        ("jdbc:mysql://localhost:3306/repo_course","root","yourpassword");
            PreparedStatement ps =con.prepareStatement
                             ("select * from courseMaterials where filename=?");
            
            ps.setString(1, filename);

            ResultSet rs = ps.executeQuery();
            st = rs.next();
        
        }catch(Exception e)
        {
            e.printStackTrace();
        }
        return st;                 
    } 
}
