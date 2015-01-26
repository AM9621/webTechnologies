/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package login;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;


public class Register extends HttpServlet {

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");
      
        String email = request.getParameter("email");
    
        
        String pass = request.getParameter("pass");
        
        String url = request.getParameter("url");
       
 
        HttpSession session = request.getSession(true);
        
        if(RegisterValidate.checkUser(email))
        {
            
            session.setAttribute("alreadyReg", "true");
            
        }
        else
        {
            
            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/repo_course",
                "root", "yourpassword");
                Statement st = con.createStatement();
                //ResultSet rs;
                st.executeUpdate("insert into register(email, pass) values ('"+ email+"', md5('"+pass+"'))");
                 
            }
            catch(Exception e){
                out.println("Register Order failed. Please contact technical support.");
            }
            
            session.setAttribute("regSuccess", "true");
           
        }
       
        response.sendRedirect(request.getContextPath() + "/thoughtData/"+url);
        //response.sendRedirect("http://localhost:8080/WTechProject/thoughtData/"+url);
    }  
    
   /*  @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
    out.println("Username or Password incorrect");
    }*/
}