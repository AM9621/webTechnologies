/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rate;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author root_
 */
public class Rate extends HttpServlet {
    

  
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection con = null;
       // String email = request.getParameter("email");
        //HttpSession session = request.getSession(true);
        String rate =  request.getParameter("rating");
        String avgRate = request.getParameter("averageRate");
        String votes = request.getParameter("votes");
        
        HttpSession session = request.getSession(true);
        String user = (String) session.getAttribute("email");
        
       
        float average = (float) (Float.parseFloat(rate)/5.0);
        float totalAverage = (float) (average + Float.parseFloat(avgRate));
        float newRank = (float) ((totalAverage/(Float.parseFloat(votes) + 1.0)) * 100.0);
        
        String url = request.getParameter("url");
        String filename = request.getParameter("fname");


        try {
            Class.forName("com.mysql.jdbc.Driver");
          //creating connection with the database 
            con=DriverManager.getConnection
                            ("jdbc:mysql://localhost:3306/repo_course","root","yourpassword");

          // Turn on transactions
            con.setAutoCommit(false);

            //query = "update courseMaterials set averageRate='"+rate+"' , First_Name='John' , " +
            //"Email='john@smarty.com' where First_Name='Jonty';";
            Statement stmt = con.createStatement();
            
            stmt.executeUpdate("UPDATE courseMaterials SET averageRate = (averageRate + '"+average+"') where filename='"+filename+"'");
            stmt.executeUpdate("UPDATE courseMaterials SET votes = (votes + 1) where filename='"+filename+"'");
            stmt.executeUpdate("UPDATE courseMaterials SET rank ='"+newRank+"' where filename='"+filename+"'");
            stmt.executeUpdate("insert into voteStat(user, file) values ('"+user+"', '"+filename+"')"); 

            con.commit();
            session.setAttribute("Rate", "true");
           
           
            //out.println("Order successful!  Thanks for your business! " + filename +" " + average +" " + newRank +" "+rate + " " + totalAverage);
        }
        catch (Exception e) {
          // Any error is grounds for rollback
            try {
                out.println("Rate Order failed. Please contact technical support.");
                con.rollback();
            }
            catch (SQLException ignored) { }
            //out.println("Order failed. Please contact technical support.");
        }
        finally {
            // Clean up.
            try {
                if (con != null) con.close();
            }
            catch (SQLException ignored) { }
        }
        
        response.sendRedirect(request.getContextPath() + "/thoughtData/"+url);
        //response.sendRedirect("http://localhost:8080/WTechProject/thoughtData/"+url);
           

    } 
}
